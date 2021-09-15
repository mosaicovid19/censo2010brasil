library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa12 <- abrir_base(base = "Pessoa12", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa12", Pessoa12)

# Salvar apenas a estrutura do data.frame
Pessoa12 <- Pessoa12 %>% head(0)
usethis::use_data(Pessoa12, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Pessoa12, add_fields = "source")
