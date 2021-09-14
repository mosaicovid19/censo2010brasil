library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa03 <- abrir_base(base = "Pessoa03", censo_dir = censo_dir, cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Pessoa03", Pessoa03)

# Salvar apenas a estrutura do data.frame
Pessoa03 <- Pessoa03 %>% head(0)
usethis::use_data(Pessoa03, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa03, add_fields = "source")
