## code to prepare `censo2010` dataset goes here

library(tidyverse)
library(readxl)
library(foreach)
library(doParallel)

source("data-raw/abrir_base_estado.R")

## localização dos dados brutos
censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

base <- "Basico"

estados <- c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
             "MG", "MS", "MT", "PA", "PB", "PE", "PI", "RJ", "RS", "SP1",
             "SP2", "TO")

# estados <- c("AC", "AP") # UF pequenas para teste
# bases <- c("Basico", "Entorno")
# bases <- "Resp.Alfa"

# cores <- detectCores() %/% 2
cores <- 2
# cl <- makePSOCKcluster(detectCores())
# registerDoParallel(cl)
registerDoParallel(cores = cores)

Basico <- foreach(e = estados, .combine = bind_rows, .packages = c("readxl"), .export = c("abrir_base_estado")) %do%
  abrir_base_estado(base, e, censo_dir)

# stopCluster(cl)
stopImplicitCluster()

usethis::use_data(Basico, overwrite = TRUE)
