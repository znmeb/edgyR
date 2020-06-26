#! /usr/bin/env Rscript

to_install <- c(
  "devtools"
)
install.packages(to_install, quiet = TRUE)
warnings()

print("Missing?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))
