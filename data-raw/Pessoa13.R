library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa13 <- abrir_base(base = "Pessoa13", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa13", Pessoa13)

# template de doc (Rd)
sinew::makeOxygen(Pessoa13, add_fields = "source")

# Salvar apenas a estrutura do data.frame
Pessoa13 <- Pessoa13 %>% head(0)
usethis::use_data(Pessoa13, overwrite = TRUE)
