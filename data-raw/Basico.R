## code to prepare `censo2010` dataset goes here

library(tidyverse)

source("data-raw/abrir_base_estado.R")

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

base <- "Basico"
cores <- 1

Basico <- abrir_base(base, cores = cores)

usethis::use_data(Basico, overwrite = TRUE)
