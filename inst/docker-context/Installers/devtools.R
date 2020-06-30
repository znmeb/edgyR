#! /usr/bin/env Rscript

to_install <- c(
  "devtools",
  "miniUI",
  "pkgdown"
)
install.packages(to_install, quiet = TRUE)
warnings()

print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))
