library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno01 <- abrir_base(base = "Entorno01", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Entorno01", Entorno01)

# Salvar apenas a estrutura do data.frame
Entorno01 <- Entorno01 %>% head(0)
usethis::use_data(Entorno01, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Entorno01, add_fields = "source")
