ARG BASE_IMAGE
FROM $BASE_IMAGE
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# externally-defined arguments
ARG R_SOURCE_TARBALL
ARG RSTUDIO_VERSION_MAJOR
ARG RSTUDIO_VERSION_MINOR
ARG RSTUDIO_VERSION_PATCH

# internal arguments
ARG DEBIAN_FRONTEND=noninteractive
ARG SOURCE_DIR=/usr/local/src
ARG EDGYR_HOME=/home/edgyr

# environment variables on image
ENV PAPERSIZE=letter
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV WORKON_HOME=$EDGYR_HOME/.virtualenvs

# image building
USER root
WORKDIR $SOURCE_DIR/

# upgrade the OS
COPY apt-upgrade $SOURCE_DIR/
RUN $SOURCE_DIR/apt-upgrade > apt-upgrade.log 2>&1 \
  && gzip -9 apt-upgrade.log

# install linux dependencies
COPY install-linux-dependencies $SOURCE_DIR/
RUN $SOURCE_DIR/install-linux-dependencies > install-linux-dependencies.log 2>&1 \
  && gzip -9 install-linux-dependencies.log

RUN locale-gen en_US.UTF-8 \
  && update-locale \
    LANG=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_NUMERIC=en_US.UTF-8 \
    LC_TIME=en_US.UTF-8 \
    LC_COLLATE=en_US.UTF-8 \
    LC_MONETARY=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_PAPER=en_US.UTF-8 \
    LC_NAME=en_US.UTF-8 \
    LC_ADDRESS=en_US.UTF-8 \
    LC_TELEPHONE=en_US.UTF-8 \
    LC_MEASUREMENT=en_US.UTF-8 \
    LC_IDENTIFICATION=en_US.UTF-8 \
  && cat /etc/default/locale

# copy R files from rstats image
COPY --from=edgyr-rstats:latest /usr/local/lib/R /usr/local/lib/R
COPY --from=edgyr-rstats:latest /usr/local/share/man/man1 /usr/local/share/man/man1
COPY --from=edgyr-rstats:latest /usr/local/bin /usr/local/bin
COPY --from=edgyr-rstats:latest /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY R.conf ld.so.conf.d/
RUN /sbin/ldconfig

# copy RStudio Server files from rstats image
COPY --from=edgyr-rstats:latest /usr/local/lib/rstudio-server /usr/local/lib/rstudio-server

# configure RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY rstudio-configure rserver.conf $SOURCE_DIR/
RUN $SOURCE_DIR/rstudio-configure

# create non-root user with 'sudo' privilege
RUN useradd \
  --shell /bin/bash \
  --user-group \
  --groups sudo \
  --create-home \
  --uid 1000 edgyr \
  && echo "edgyr:edgyr" | chpasswd

# populate 'edgyr' home
COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr Renviron $EDGYR_HOME/.Renviron
COPY --chown=edgyr:edgyr Installers $EDGYR_HOME/Installers
RUN mkdir --parents $WORKON_HOME $PROJECT_HOME; chown -R edgyr:edgyr $EDGYR_HOME

# shift to 'edgyr' account to install 'r-reticulate' virtual environment
# and R Python interface packages
USER edgyr
WORKDIR $EDGYR_HOME
RUN Installers/r-reticulate > Installers/r-reticulate.log 2>&1 \
  && gzip -9 Installers/r-reticulate.log
RUN Installers/rmarkdown.R > Installers/rmarkdown.R.log 2>&1 \
  && gzip -9 Installers/rmarkdown.R.log
RUN Installers/devtools.R > Installers/devtools.R.log 2>&1 \
  && gzip -9 Installers/devtools.R.log

# go back to 'root' and set up entry point
USER root
WORKDIR $SOURCE_DIR
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
COPY --chown=edgyr:edgyr Scripts $EDGYR_HOME/Scripts
