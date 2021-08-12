library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

DomicilioRenda <- abrir_base(base = "DomicilioRenda", cores = cores)

# Salvar apenas a estrutura do data.frame
DomicilioRenda <- DomicilioRenda %>% head(0)
usethis::use_data(DomicilioRenda, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(DomicilioRenda, add_fields = "source")
