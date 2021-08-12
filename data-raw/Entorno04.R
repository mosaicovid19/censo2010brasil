library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno04 <- abrir_base(base = "Entorno04", cores = cores)

# Salvar apenas a estrutura do data.frame
Entorno04 <- Entorno04 %>% head(0)
usethis::use_data(Entorno04, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Entorno04, add_fields = "source")
