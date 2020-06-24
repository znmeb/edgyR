R on the Edge: NVIDIAⓇ Jetson™ Developer Utilities
================

## Overview

> And though she be but little, she is fierce. - Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The goal of `edgyR` is to provide utilities for using R on NVIDIA Jetson
development kits. The Jetson kits include a complete NVIDIA Docker
runtime, so `edgyR` provides `bash` scripts that create a Docker image
with R and RStudio Server built from source. The image takes a fair
amount of time to build, even on an 8-core Xavier AGX. So a copy of it
is pushed to Docker Hub for downloading at the end of the build process.

The base image for the build is
<https://ngc.nvidia.com/catalog/containers/nvidia:l4t-base>. The
operating system in the Jetson kits and on the image is
[L4T](https://docs.nvidia.com/jetson/l4t/index.html), Ubuntu `Bionic`
for the `arm64` processor with numerous NVIDIA packages added, including
CUDA 10.2 and libraries to use the GPU on a Jetson development kit.

Future versions of `edgyR` will have functions for installing and
accessing more GPU functionality, including both TensorFlow and PyTorch.
The target market for the Jetson product line is autonomous vehicles,
and NVIDIA provides a wealth of computer vision / deep learning
inference software for the boards.

## Installation

You can install `edgyR` from [GitHub](https://github.com/znmeb/edgyR)
with:

``` r
remotes::install_packages_github("znmeb/edgyR@default")
```

Note that the default branch is called `default`, *not* `master`. This
software only runs on Jetson Nano and Xavier developer kits. It will not
run on a “conventional” `x86_64` machine.
