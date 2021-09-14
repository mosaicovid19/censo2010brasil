library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Basico <- abrir_base(base = "Basico", censo_dir = censo_dir, cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Basico", Basico)

# Salvar apenas a estrutura do data.frame
Basico <- Basico %>% head(0)
usethis::use_data(Basico, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Basico, add_fields = "source")
