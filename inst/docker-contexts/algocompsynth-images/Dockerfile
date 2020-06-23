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
ARG ALGOCOMPSYNTH_HOME=/home/algocompsynth

# environment variables on image
ENV PAPERSIZE=letter
ENV PROJECT_HOME=$ALGOCOMPSYNTH_HOME/Projects
ENV WORKON_HOME=$ALGOCOMPSYNTH_HOME/.virtualenvs

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
COPY install-r R.conf $SOURCE_DIR/
RUN $SOURCE_DIR/install-r > install-r.log 2>&1 && \
  gzip -9 install-r.log

# install RStudio Server
COPY install-rstudio-server $SOURCE_DIR/
RUN $SOURCE_DIR/install-rstudio-server > install-rstudio-server.log 2>&1 && \
  gzip -9 install-rstudio-server.log

# configure RStudio Server
COPY rstudio-configure rserver.conf $SOURCE_DIR/
RUN $SOURCE_DIR/rstudio-configure

# create non-root user with 'sudo' privilege
RUN useradd \
  --shell /bin/bash \
  --user-group \
  --groups sudo \
  --create-home \
  --uid 1000 algocompsynth \
  && echo "algocompsynth:algocompsynth" | chpasswd

# populate 'algocompsynth' home
COPY --chown=algocompsynth:algocompsynth bash_aliases $ALGOCOMPSYNTH_HOME/.bash_aliases
COPY --chown=algocompsynth:algocompsynth Rprofile $ALGOCOMPSYNTH_HOME/.Rprofile
COPY --chown=algocompsynth:algocompsynth Renviron $ALGOCOMPSYNTH_HOME/.Renviron
COPY --chown=algocompsynth:algocompsynth Installers $ALGOCOMPSYNTH_HOME/Installers

# install dependencies for Python and R packages
RUN $ALGOCOMPSYNTH_HOME/Installers/apt-packages > $ALGOCOMPSYNTH_HOME/Installers/apt-packages.log 2>&1 && \
  gzip -9 $ALGOCOMPSYNTH_HOME/Installers/apt-packages.log
RUN chown -R algocompsynth:algocompsynth $ALGOCOMPSYNTH_HOME/

# run as 'algocompsynth'
USER algocompsynth
WORKDIR $ALGOCOMPSYNTH_HOME/

# set up Python virtulaenv and R library
RUN $ALGOCOMPSYNTH_HOME/Installers/create-venvs > $ALGOCOMPSYNTH_HOME/Installers/create-venvs.log 2>&1 && \
  gzip -9 $ALGOCOMPSYNTH_HOME/Installers/create-venvs.log

# install Python packages
RUN $ALGOCOMPSYNTH_HOME/Installers/pip-installs > $ALGOCOMPSYNTH_HOME/Installers/pip-installs.log 2>&1 && \
  gzip -9 $ALGOCOMPSYNTH_HOME/Installers/pip-installs.log

# install R packages
RUN $ALGOCOMPSYNTH_HOME/Installers/R-installs > $ALGOCOMPSYNTH_HOME/Installers/R-installs.log 2>&1 && \
  gzip -9 $ALGOCOMPSYNTH_HOME/Installers/R-installs.log

# switch back to root
USER root
WORKDIR $SOURCE_DIR/

# set up entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]

# copy test scripts to image
COPY --chown=algocompsynth:algocompsynth TestScripts $ALGOCOMPSYNTH_HOME/TestScripts
