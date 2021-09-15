library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa06 <- abrir_base(base = "Pessoa06", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa06", Pessoa06, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Pessoa06, add_fields = "source"), "\n"), file = "R/Pessoa06.R")

# Salvar apenas a estrutura do data.frame
Pessoa06 <- Pessoa06 %>% head(0)
usethis::use_data(Pessoa06, overwrite = TRUE)
