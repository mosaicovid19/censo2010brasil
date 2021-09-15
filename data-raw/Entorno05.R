library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno05 <- abrir_base(base = "Entorno05", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Entorno05", Entorno05)

# template de doc (Rd)
sinew::makeOxygen(Entorno05, add_fields = "source")

# Salvar apenas a estrutura do data.frame
Entorno05 <- Entorno05 %>% head(0)
usethis::use_data(Entorno05, overwrite = TRUE)
