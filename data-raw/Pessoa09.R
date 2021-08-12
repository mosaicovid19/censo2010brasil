library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa09 <- abrir_base(base = "Pessoa09", cores = cores)

# Salvar apenas a estrutura do data.frame
Pessoa09 <- Pessoa09 %>% head(0)
usethis::use_data(Pessoa09, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa09, add_fields = "source")
