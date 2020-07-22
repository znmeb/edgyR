#! /usr/bin/env Rscript

# update old packages into user library
print("")
print("Updating system packages")
install.packages(as.data.frame(old.packages())$Package)

print("")
print("Installing new packages")
install.packages(c(
  "caracas",
  "data.table",
  "DiagrammeR",
  "greta",
  "igraph",
  "IRkernel",
  "keras",
  "rTorch"
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
