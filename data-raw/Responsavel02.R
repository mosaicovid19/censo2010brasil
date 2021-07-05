library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Responsavel02 <- abrir_base(base = "Responsavel02", cores = cores)

usethis::use_data(Responsavel02, overwrite = TRUE)
