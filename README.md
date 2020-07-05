edgyR: R on the Edge – NVIDIAⓇ Jetson™ tools for R developers
================

## Overview

> “And though she be but little, she is fierce.” – Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The goal of `edgyR` is to give R users access to [NVIDIA Jetson
development
kits](https://developer.nvidia.com/embedded/develop/hardware). Although
the target market of the Jetson platform is autonomous vehicles and the
focus of the software is image and video processing, the hardware and
software are general enough for a wide variety of machine learning
applications.

The Jetson software is called JetPack.
[JetPack](https://developer.nvidia.com/embedded/jetpack) includes a full
Ubuntu 18.04 LTS “Bionic Beaver” desktop, NVIDIA drivers and GPU
development software, Python libraries for accessing the GPU, and a
complete NVIDIA Docker runtime.

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

### 2020-07-04:

The documentation is about 80 percent complete. It’s certainly ready for
reviewing / feedback / issues. Start here:
`vignette("aa-setting-up-the-jetson-nano")`.

I may drop the small images before the final v0.5.0 release. I rarely
run them and I think having three images will be confusing to beginners.

I regularly test on a Jetson Nano and a Jetson Xavier AGX and I expect
everything will also run on the new Jetson Xavier NX. I do not plan to
support the older Jetson “TX” series devices.
