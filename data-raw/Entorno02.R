library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno02 <- abrir_base(base = "Entorno02", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Entorno02", Entorno02)

# Salvar apenas a estrutura do data.frame
Entorno02 <- Entorno02 %>% head(0)
usethis::use_data(Entorno02, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Entorno02, add_fields = "source")
