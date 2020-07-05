#! /usr/bin/env Rscript

to_install <- c(
  "knitr",
  "rmarkdown",
  "rprojroot",
  "tinytex"
)
install.packages(to_install, quiet = TRUE)
warnings()

print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))

print("You can ignore errors in the following TinyTeX install")
try(tinytex::install_tinytex())
