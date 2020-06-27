R on the Edge: NVIDIAⓇ Jetson™ tools for R developers
================

## Overview

> “And though she be but little, she is fierce.” – Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The goal of `edgyR` is to give R users access to [NVIDIA Jetson
development
kits](https://developer.nvidia.com/embedded/develop/hardware). The
Jetson software includes a full Ubuntu 18.04LTS “Bionic Beaver” desktop,
NVIDIA GPU development software and a complete NVIDIA Docker runtime.

## How is it pronounced?

There are (at least) five options:

1.  ED-grrr
2.  ED-gyre
3.  Edger
4.  Edgier
5.  Edgy R

It is ***not*** pronounced like any brand of peanut butter. Otherwise,
it’s your choice\!

## Status / Roadmap

### 2020-06-26:

There are now three images:

1.  [edgyr-rstats](https://hub.docker.com/repository/docker/znmeb/edgyr-rstats):
    This image is based on the ARM64 version of Ubuntu 18.04 LTS “Bionic
    Beaver”. It has R 4.0.2 and RStudio Server 1.3.959 compiled from
    source but it has no NVIDIA software. It should run on any ARM64
    Linux Docker host, but I only test it on the Xavier AGX and the
    Nano.
    
    The main reason I made this image is to host the binaries from the R
    and RStudio Server compilation / linking process. The other images
    copy these binaries from `edgyr-rstats` rather than having to
    re-compile them.

2.  [edgyr-base](https://hub.docker.com/repository/docker/znmeb/edgyr-base):
    This is functionally the same as the previous version of the same
    name, but it’s smaller and takes less time to build. It is based on
    [nvidia-l4t-base](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-base).

3.  [edgyr-ml](https://hub.docker.com/repository/docker/znmeb/edgyr-ml):
    This is the “batteries included” / “kitchen sink” image. It is based
    on [Machine Learning for
    Jetson/L4T](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-ml).
    It’s large - 6.14 GB - and it has PyTorch 1.5.0, TensorFlow 1.15,
    torchvision, Keras, scikit-learn, pandas and JupyterLab. I don’t
    have a JupyterLab server running yet but it’s on the road map for
    v0.5.0.

### 2020-06-24:

The first release of `edgyR`, v0.5.0, will provide `bash` scripts to
create a Docker image with R and RStudio Server built from source. The
completed image will be posted on Docker Hub at
<https://hub.docker.com/repository/docker/znmeb/edgyr-base>. The base
image for the build is
<https://ngc.nvidia.com/catalog/containers/nvidia:l4t-base>.

The bulk of this is done; the scripts work and the image is pushed to
Docker Hub. I need to do a final cleanup round and finish the
documentation, but I’m using the image now. Note that v0.5.0 contains
zero R content except a dummy function to gruntle `devtools::check()`.
All that’s here is `bash` scripts in `inst/docker-context`.

The next release, v0.9.0, will provide both PyTorch and TensorFlow 2,
and may also provide TensorFlow 1, since quite a few AI projects out
there are still using TensorFlow 1. It takes a fair amount of time to
install TensorFlow and the resulting image is much bigger, so there will
be another image posted to Docker Hub when that’s done.

NVIDIA provides an [L4T machine learning
image](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-ml) with
TensorFlow 1, PyTorch and a few other commonly used Python machine
learning tools, including JupyterLab\! So if you’ve got a Jetson and
know Python and are in a hurry to get some code going, you can get
started that way. The target market for the Jetson product line is
autonomous vehicles, and NVIDIA provides a wealth of computer vision /
deep learning inference software for the boards. See [NVIDIA NGC L4T
containers](https://ngc.nvidia.com/catalog/containers?orderBy=modifiedDESC&pageNumber=0&query=l4t&quickFilter=containers&filters=)
for a catalog of Docker images that will run on the Jetson.

## Installation

You will need a Jetson development kit to run the Docker image build
scripts or to run the built image. See
`vignette("aa-setting-up-the-jetson-nano")` if you don’t have the
hardware yet.

You can install `edgyR` from [GitHub](https://github.com/znmeb/edgyR)
with:

``` r
remotes::install_packages_github("znmeb/edgyR")
```

or you can clone the repository:

``` bash
git clone https://github.com/znmeb/edgyR.git
```

But as noted above, there’s not much point for end users to install this
package yet unless you want the documentation in your RStudio
environment rather than having to go to
<https://znmeb.github.io/edgyR/>. But I welcome people with the hardware
to open issues at <https://github.com/znmeb/edgyR/issues>.

I regularly test on a Jetson Nano and a Jetson Xavier AGX and I expect
everything will also run on the new Jetson Xavier NX. I do not plan to
support the older Jetson “TX” series devices.
