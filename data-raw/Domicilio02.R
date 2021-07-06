library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Domicilio02 <- abrir_base(base = "Domicilio02", cores = cores)

usethis::use_data(Domicilio02, overwrite = TRUE)
