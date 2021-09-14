library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa06 <- abrir_base(base = "Pessoa06", censo_dir = censo_dir, cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Pessoa06", Pessoa06)

# Salvar apenas a estrutura do data.frame
Pessoa06 <- Pessoa06 %>% head(0)
usethis::use_data(Pessoa06, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa06, add_fields = "source")
