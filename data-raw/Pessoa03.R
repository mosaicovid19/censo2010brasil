library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

cores <- 1

Pessoa03 <- abrir_base(base = "Pessoa03", cores = cores)

usethis::use_data(Pessoa03, overwrite = TRUE)
