#! /usr/bin/env Rscript

to_install <- c(
  "keras",
  "reticulate",
  "rTorch"
)
install.packages(to_install, quiet = TRUE)
warnings()

print("Missing packages?")
print(setdiff(to_install, as.data.frame(installed.packages())$Package))

reticulate::py_discover_config()
print("Is keras available?")
keras::is_keras_available()
