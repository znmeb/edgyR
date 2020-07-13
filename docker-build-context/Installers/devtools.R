#! /usr/bin/env Rscript

to_install <- c(
  "caracas",
  "data.table",
  "devtools",
  "keras",
  "knitr",
  "miniUI",
  "pkgdown",
  "rmarkdown",
  "rprojroot",
  "rTorch",
  "tinytex"
)

# update old packages into user library
install.packages(as.data.frame(old.packages())$Package)

install.packages(to_install, quiet = TRUE)
warnings()

print("")
print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))

print("")
print("You can ignore errors in the following TinyTeX install")
try(tinytex::install_tinytex())
print("You can ignore errors in the preceding TinyTeX install")
print("")

print("")
print("Is 'r-reticulate' available?")
reticulate::py_discover_config()

print("")
print("Installed R packages")
print(
  subset(
    as.data.frame(
      installed.packages()),
    select = c(Package, Version)),
row.names = FALSE, max = 1000000)
