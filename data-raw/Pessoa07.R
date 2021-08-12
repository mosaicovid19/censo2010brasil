library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa07 <- abrir_base(base = "Pessoa07", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Pessoa07", Pessoa07)

# Salvar apenas a estrutura do data.frame
Pessoa07 <- Pessoa07 %>% head(0)
usethis::use_data(Pessoa07, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa07, add_fields = "source")
