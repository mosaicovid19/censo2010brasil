library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(is.null(cores)) cores <- 1

Entorno03 <- abrir_base(base = "Entorno03", cores = cores)

usethis::use_data(Entorno03, overwrite = TRUE)
