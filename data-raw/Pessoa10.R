library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa10 <- abrir_base(base = "Pessoa10", cores = cores)

# Salvar apenas a estrutura do data.frame
Pessoa10 <- Pessoa10 %>% head(0)
usethis::use_data(Pessoa10, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa10, add_fields = "source")
