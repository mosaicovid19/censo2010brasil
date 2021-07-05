library(tidyverse)

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

cores <- 1

DomicilioRenda <- abrir_base(base = "DomicilioRenda", cores = cores)

usethis::use_data(DomicilioRenda, overwrite = TRUE)
