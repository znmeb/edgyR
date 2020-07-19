#! /usr/bin/env Rscript

print("")
print("Initializing 'tensorflow-2'")
reticulate::use_python("~/.virtualenvs/tensorflow-2/bin/python3", required = TRUE)
reticulate::use_virtualenv("tensorflow-2", required = TRUE)
print(reticulate::py_config())
print("")
print("Is 'keras' available?")
print(keras::is_keras_available())
print("")
print("Does 'greta' work?")
print("see 'https://cran.r-project.org/web/packages/greta/vignettes/get_started.html'")
library(greta)

# data
x <- as_data(iris$Petal.Length)
y <- as_data(iris$Sepal.Length)

# variables and priors
int <- normal(0, 1)
coef <- normal(0, 3)
sd <- student(3, 0, 1, truncation = c(0, Inf))

# operations
mean <- int + coef * x

# likelihood
distribution(y) <- normal(mean, sd)

# defining the model
m <- model(int, coef, sd)

# plotting
plot(m)

# sampling
draws <- mcmc(m, n_samples = 1000)
