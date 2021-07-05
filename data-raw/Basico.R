library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(is.null(cores)) cores <- 1

Basico <- abrir_base(base = "Basico", cores = cores)

usethis::use_data(Basico, overwrite = TRUE)
