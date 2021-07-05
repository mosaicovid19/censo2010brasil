library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Domicilio01 <- abrir_base(base = "Domicilio01", cores = cores)

usethis::use_data(Domicilio01, overwrite = TRUE)
