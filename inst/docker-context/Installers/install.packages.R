#! /usr/bin/env Rscript

to_install <- c(
  "renv",
  "reticulate"
)
install.packages(to_install, quiet = TRUE)
warnings()
reticulate::py_discover_config()

print("Missing")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))
