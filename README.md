edgyR: R on the Edge – NVIDIAⓇ Jetson™ tools for R developers
================

### Main documentation site: <https://znmeb.github.io/edgyR>

### Docker image: <https://hub.docker.com/r/znmeb/edgyr-ml>

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

The initial release is aimed at R package developers. I’m assuming a
knowledge of R, RStudio, Git, and R Markdown. The release contains
everything an R package developer should need to develop packages that
interface with the unique hardware of the Jetson platform.

The Jetson hardware consists of a multi-core `arm64` CPU and a
CUDA-compatible GPU. The smallest of the family, the Jetson Nano, has
four CPU cores, 4 GB of RAM, and a GPU with 128 CUDA cores. The peak
speed is 472 billion floating point operations per second (GFLOPS).

The Jetson software is called
[JetPack](https://developer.nvidia.com/embedded/jetpack). JetPack
includes

  - [Linux for Tegra
    (L4T)](https://developer.nvidia.com/embedded/linux-tegra), a full
    Ubuntu 18.04 LTS “Bionic Beaver” desktop,
  - NVIDIA drivers,
  - compilers, linkers and libraries to access the onboard GPU in C/C++
    and Python, and
  - a complete NVIDIA Docker runtime.

`edgyR` adds R 4.0.2 and RStudio Server 1.3.959 to JetPack, compiled for
`arm64` from upstream source and packaged on a Docker image,
[`edgyr-ml`](https://hub.docker.com/r/znmeb/edgyr-ml). The image is
based on [Machine Learning for
Jetson/L4T](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-ml). As
a result, `edgyr-ml` includes numpy, scipy, matplotlib, pandas,
scikit-learn, onnx, PyTorch 1.5.0, torchvision 0.6.0, TensorFlow 1.15,
and JupyterLab 2.1.1.

## How is it pronounced?

There are (at least) five options:

1.  ED-grrr
2.  ED-gyre
3.  EDGE-er
4.  Edgier
5.  Edgy R

It is ***not*** pronounced like any brand of peanut butter. Otherwise,
it’s your choice\!

## Onward\!

`vignette("aa-setting-up-the-jetson-nano")`
