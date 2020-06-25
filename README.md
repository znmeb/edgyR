R on the Edge: NVIDIAⓇ Jetson™ Developer Utilities
================

## Overview

> “And though she be but little, she is fierce.” – Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The goal of `edgyR` is to give R users access to [NVIDIA Jetson
development
kits](https://developer.nvidia.com/embedded/develop/hardware). The
Jetson software includes a full Ubuntu 18.04LTS “Bionic Beaver” desktop,
NVIDIA GPU development software and a complete NVIDIA Docker runtime.

The first release of `edgyR` provides `bash` scripts to create a Docker
image with R and RStudio Server built from source. The completed image
is posted on Docker Hub at
<https://hub.docker.com/repository/docker/znmeb/edgyr-jetson-base>. The
base image for the build is
<https://ngc.nvidia.com/catalog/containers/nvidia:l4t-base>.

Future versions of `edgyR` will have R functions for installing and
accessing Jetson GPU functionality, including both TensorFlow and
PyTorch. The target market for the Jetson product line is autonomous
vehicles, and NVIDIA provides a wealth of computer vision / deep
learning inference software for the boards. See [NVIDIA NGC L4T
containers](https://ngc.nvidia.com/catalog/containers?orderBy=modifiedDESC&pageNumber=0&query=l4t&quickFilter=containers&filters=)
for a catalog of Docker images that will run on the Jetson.

## Installation

You will need a Jetson development kit to run the Docker image build
scripts or to run the built image. See
`vignette("setting-up-the-jetson-nano")` if you don’t have the hardware
yet.

You can install `edgyR` from [GitHub](https://github.com/znmeb/edgyR)
with:

``` r
remotes::install_packages_github("znmeb/edgyR")
```

or you can clone the repository:

``` bash
git clone https://github.com/znmeb/edgyR.git
```

There’s not much point for end users to install this package yet unless
you want the documentation in your RStudio environment rather than
having to go to <https://znmeb.github.io/edgyR/>. But I welcome people
with the hardware to open issues at
<https://github.com/znmeb/edgyR/issues> if you want to go through the
image build process.

I regularly test on a Jetson Nano and a Jetson Xavier AGX and I expect
everything will also run on the new Jetson Xavier NX. I do not plan to
support the older Jetson “TX” series devices.
