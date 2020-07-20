#! /usr/bin/env Rscript

to_install <- c(
  "caracas",
  "data.table",
  "devtools",
  "DiagrammeR",
  "greta",
  "igraph",
  "keras",
  "knitr",
  "miniUI",
  "pkgdown",
  "rmarkdown",
  "rprojroot",
  "rTorch"
)

# update old packages into user library
print("")
print("Updating system packages")
install.packages(as.data.frame(old.packages())$Package)

# do TinyTeX first - it's sensitive to network issues
print("")
print("Installing TinyTeX")
print("You can ignore errors in the following TinyTeX install")
install.packages("tinytex", quiet = TRUE)
warnings()
try(tinytex::install_tinytex())
print("You can ignore errors in the preceding TinyTeX install")
print("Testing TinyTeX - these errors matter!")
options(warn = 2)
print(tinytex::tlmgr_conf())

print("")
print("Installing developer tools")
install.packages(to_install, quiet = TRUE)
warnings()

print("")
print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))

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
