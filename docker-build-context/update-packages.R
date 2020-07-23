#! /usr/bin/env Rscript

local({
   r <- getOption("repos");
   r["CRAN"] <- "https://cloud.r-project.org/"
   options(repos=r)
})

install.packages(as.data.frame(old.packages())$Package)
