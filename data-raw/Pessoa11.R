library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa11 <- abrir_base(base = "Pessoa11", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa11", Pessoa11, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Pessoa11, add_fields = "source"), "\n"), file = "R/Pessoa11.R")

# Salvar apenas a estrutura do data.frame
Pessoa11 <- Pessoa11 %>% head(0)
usethis::use_data(Pessoa11, overwrite = TRUE)
