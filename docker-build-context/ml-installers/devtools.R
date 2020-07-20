#! /usr/bin/env Rscript

# do TinyTeX first - it's sensitive to network issues
print("")
print("Installing TinyTeX")
print("You can ignore errors in the following TinyTeX install")
install.packages("tinytex", quiet = TRUE)
warnings()
try(tinytex::install_tinytex())
print("You can ignore errors in the preceding TinyTeX install")
print("")
print("Testing TinyTeX - these errors matter!")
options(warn = 2)
print(tinytex::tlmgr_conf())
options(warn = 0)

print("")
print("Installing developer tools")
install.packages(c(
  "devtools",
  "DiagrammeR",
  "greta",
  "igraph",
  "knitr",
  "miniUI",
  "pkgdown",
  "rmarkdown",
  "rprojroot"
), quiet = TRUE)
warnings()
