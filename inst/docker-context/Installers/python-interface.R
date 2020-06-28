#! /usr/bin/env Rscript

to_install <- c(
  "caracas",
  "data.table",
  "keras",
  "reticulate",
  "rTorch"
)
install.packages(to_install, quiet = TRUE)
warnings()

print("")
print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))

reticulate::py_discover_config()
print("")
print("Is keras available?")
keras::is_keras_available()
print("")
print("Installed R packages")
print(
  subset(
    as.data.frame(
      installed.packages()),
    select = c(Package, Version)),
row.names = FALSE, max = 1000000)
