library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Responsavel01 <- abrir_base(base = "Responsavel01", cores = cores)

# Salvar apenas a estrutura do data.frame
Responsavel01 <- Responsavel01 %>% head(0)
usethis::use_data(Responsavel01, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Responsavel01, add_fields = "source")
