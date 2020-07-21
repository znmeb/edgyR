#! /usr/bin/env Rscript

print("")
print("Installing 'greta'")
install.packages(c(
  "DiagrammeR",
  "greta",
  "igraph"
), quiet = TRUE)
warnings()
