library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa08 <- abrir_base(base = "Pessoa08", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa08", Pessoa08)

# template de doc (Rd)
sinew::makeOxygen(Pessoa08, add_fields = "source")

# Salvar apenas a estrutura do data.frame
Pessoa08 <- Pessoa08 %>% head(0)
usethis::use_data(Pessoa08, overwrite = TRUE)
