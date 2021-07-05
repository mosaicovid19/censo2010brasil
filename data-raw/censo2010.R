## code to prepare `censo2010` dataset goes here

library(tidyverse)

source("data-raw/abrir_base_estado.R")

## localização dos dados brutos
censo_dir <- file.path("~/Downloads/Censo2010")

bases <- c("Basico", "Entorno", "Domicilio01", "Domicilio02", "Pessoa",
           "Dom.Renda", "Resp.Alfa")

estados <- c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
             "MG", "MS", "MT", "PA", "PB", "PE", "PI", "RJ", "RS", "SP1",
             "SP2", "TO")

# estados <- c("AC", "AP") # UF pequenas para teste
# bases <- c("Basico", "Entorno")
# bases <- "Resp.Alfa"

cores <- detectCores() %/% 2
cores <- 2
# cl <- makePSOCKcluster(detectCores())
# registerDoParallel(cl)
registerDoParallel(cores = cores)

censo2010 <- foreach(b = bases, .packages = c("readxl"), .export = c("abrir_base_estado")) %:%
  foreach(e = estados, .combine = bind_rows) %do%
  abrir_base_estado(b, e, censo_dir)
names(censo2010) <- bases

# stopCluster(cl)
stopImplicitCluster()

usethis::use_data(censo2010, overwrite = TRUE)
