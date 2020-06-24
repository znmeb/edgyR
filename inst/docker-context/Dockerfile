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
ARG BUILDING_DOCKER_IMAGE=yes
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
RUN $SOURCE_DIR/apt-upgrade > apt-upgrade.log 2>&1; \
  gzip -9 apt-upgrade.log

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

# install R
# see https://cloud.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes
COPY install-r R.conf $SOURCE_DIR/
RUN $SOURCE_DIR/install-r > install-r.log 2>&1 && \
  gzip -9 install-r.log

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
COPY install-rstudio-server $SOURCE_DIR/
RUN $SOURCE_DIR/install-rstudio-server > install-rstudio-server.log 2>&1 && \
  gzip -9 install-rstudio-server.log

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

# install dependencies for Python and R packages
RUN $EDGYR_HOME/Installers/apt-packages > $EDGYR_HOME/Installers/apt-packages.log 2>&1 && \
  gzip -9 $EDGYR_HOME/Installers/apt-packages.log
RUN chown -R edgyr:edgyr $EDGYR_HOME/

# run as 'edgyr'
USER edgyr
WORKDIR $EDGYR_HOME/

# set up Python virtulaenv and R library
RUN $EDGYR_HOME/Installers/create-venvs > $EDGYR_HOME/Installers/create-venvs.log 2>&1 && \
  gzip -9 $EDGYR_HOME/Installers/create-venvs.log

# install Python packages
RUN $EDGYR_HOME/Installers/pip-installs > $EDGYR_HOME/Installers/pip-installs.log 2>&1 && \
  gzip -9 $EDGYR_HOME/Installers/pip-installs.log

# install R packages
RUN $EDGYR_HOME/Installers/R-installs > $EDGYR_HOME/Installers/R-installs.log 2>&1 && \
  gzip -9 $EDGYR_HOME/Installers/R-installs.log

# switch back to root
USER root
WORKDIR $SOURCE_DIR/

# set up entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]

# copy test scripts to image
COPY --chown=edgyr:edgyr TestScripts $EDGYR_HOME/TestScripts
