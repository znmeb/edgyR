FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# externally-defined arguments
ARG R_SOURCE_TARBALL
ARG RSTUDIO_VERSION_MAJOR
ARG RSTUDIO_VERSION_MINOR
ARG RSTUDIO_VERSION_PATCH

# internal arguments
ARG DEBIAN_FRONTEND=noninteractive
ARG SOURCE_DIR=/usr/local/src

# environment variables on image
ENV PAPERSIZE=letter

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

# install R
# see https://cloud.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes
COPY install-r R.conf $SOURCE_DIR/
RUN $SOURCE_DIR/install-r > install-r.log 2>&1 \
  && gzip -9 install-r.log

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
COPY install-rstudio-server $SOURCE_DIR/
RUN $SOURCE_DIR/install-rstudio-server > install-rstudio-server.log 2>&1 \
  && gzip -9 install-studio-server.log
