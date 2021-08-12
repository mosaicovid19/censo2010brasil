library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa02 <- abrir_base(base = "Pessoa02", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Pessoa02", Pessoa02)

# Salvar apenas a estrutura do data.frame
Pessoa02 <- Pessoa02 %>% head(0)
usethis::use_data(Pessoa02, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa02, add_fields = "source")
