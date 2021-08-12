library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa01 <- abrir_base(base = "Pessoa01", cores = cores)

# Salvar apenas a estrutura do data.frame
Pessoa01 <- Pessoa01 %>% head(0)
usethis::use_data(Pessoa01, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa01, add_fields = "source")
