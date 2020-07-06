edgyR: R on the Edge – NVIDIAⓇ Jetson™ tools for R developers
================

## Overview

> “And though she be but little, she is fierce.” – Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The goal of `edgyR` is to give R users access to [NVIDIA Jetson
development
kits](https://developer.nvidia.com/embedded/develop/hardware). Although
the target market of the Jetson platform is autonomous vehicles, and the
focus of the software is image and video processing, the hardware and
software are general enough for a wide variety of machine learning
applications.

The Jetson software is called
[JetPack](https://developer.nvidia.com/embedded/jetpack). JetPack
includes [Linux for Tegra
(L4T)](https://developer.nvidia.com/embedded/linux-tegra), a full Ubuntu
18.04 LTS “Bionic Beaver” desktop with NVIDIA drivers. JetPack also
includes development software and libraries to access the onboard GPU in
C/C++ and Python, and a complete NVIDIA Docker runtime.

`edgyR` adds R 4.0.2 and RStudio Server 1.3.959 to JetPack, compiled for
`arm64` from upstream source and packaged on a Docker image,
[`edgyr-ml`](https://hub.docker.com/r/znmeb/edgyr-ml). The image is
based on [Machine Learning for
Jetson/L4T](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-ml). As
a result, `edgyr-ml` includes PyTorch 1.5.0, TensorFlow 1.15, and
JupyterLab 2.1.1.

## How is it pronounced?

There are (at least) five options:

1.  ED-grrr
2.  ED-gyre
3.  EDGE-er
4.  Edgier
5.  Edgy R

It is ***not*** pronounced like any brand of peanut butter. Otherwise,
it’s your choice\!

## Status / Roadmap

### 2020-07-05:

Simplification time\! There are now only two images and only one is
meant for normal use. The `edgyr-rstats` image has been renamed
`edgyr-source`, and is used only in the build process for R and RStudio
Server.

The main end-user image is `edgyr-ml`. It’s built on the NVIDIA L4T
machine learning image and has JupyterLab, PyTorch 1.5 and TensorFlow
1.15.

I hope at some point there will be upstream binaries for R and RStudio
Server so I don’t need to build them from source and can eliminate the
`edgyr-source` image and remove the time it takes to build it from my
release process. The more users this project gets, the more likely that
is. So if you’re using `edgyR`, tell your friends\!

### 2020-07-04:

The documentation is about 80 percent complete. It’s certainly ready for
reviewing / feedback / issues. Start here:
`vignette("aa-setting-up-the-jetson-nano")`.

I may drop the small images before the final v0.5.0 release. I rarely
run them and I think having three images will be confusing to beginners.

I regularly test on a Jetson Nano and a Jetson Xavier AGX and I expect
everything will also run on the new Jetson Xavier NX. I do not plan to
support the older Jetson “TX” series devices.
