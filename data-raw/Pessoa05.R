library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa05 <- abrir_base(base = "Pessoa05", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa05", Pessoa05, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Pessoa05, add_fields = "source"), "\n"), file = "R/Pessoa05.R")

# Salvar apenas a estrutura do data.frame
Pessoa05 <- Pessoa05 %>% head(0)
usethis::use_data(Pessoa05, overwrite = TRUE)
