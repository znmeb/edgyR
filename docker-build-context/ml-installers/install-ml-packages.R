#! /usr/bin/env Rscript

# update old packages into user library
print("")
print("Updating system packages")
install.packages(as.data.frame(old.packages())$Package)

print("")
print("Installing new packages")
install.packages(c(
  "caracas",
  "data.table",
  "IRkernel",
  "keras",
  "rTorch"
), quiet = TRUE)
warnings()
IRkernel::installspec()
