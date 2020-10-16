#! /usr/bin/env Rscript

# do TinyTeX first - it's sensitive to network issues
print("")
print("Installing TinyTeX")
print("You can ignore errors in the following TinyTeX install")
install.packages("remotes", quiet = TRUE)
remotes::install_github(repo = "yihui/tinytex", ref = "v0.25", quiet = TRUE)
warnings()
try(tinytex::install_tinytex())
print("You can ignore errors in the preceding TinyTeX install")
print("")
print("Testing TinyTeX - these errors matter!")
options(warn = 2)
print(tinytex::tlmgr_conf())
options(warn = 0)

install.packages(c(
  "caracas",
  "data.table",
  "devtools",
  "DiagrammeR",
  "DT",
  "greta",
  "knitr",
  "igraph",
  "IRkernel",
  "keras",
  "miniUI",
  "pkgdown",
  "rmarkdown",
  "rprojroot",
  "rTorch",
  "shiny",
  "tidyverse",
  "torch"
), quiet = TRUE)
warnings()
IRkernel::installspec()

print("")
print("Initializing Python 3")
reticulate::use_python("/usr/bin/python3", required = TRUE)
print(reticulate::py_config())
print("")
print("Is 'keras' available?")
print(keras::is_keras_available())
print("")
print("Does 'caracas' work?")
library(caracas)
A <- matrix(c("x", 2, 0, "2*x"), 2, 2)
B <- as_symbol(A)
print(B)
Binv <- inv(B)
print(Binv)
tex(Binv)
print(eigen_val(Binv))
