library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa04 <- abrir_base(base = "Pessoa04", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Pessoa04", Pessoa04)

# Salvar apenas a estrutura do data.frame
Pessoa04 <- Pessoa04 %>% head(0)
usethis::use_data(Pessoa04, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa04, add_fields = "source")
