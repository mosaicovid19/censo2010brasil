library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno01 <- abrir_base(base = "Entorno01", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Entorno01", Entorno01, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Entorno01, add_fields = "source"), "\n"), file = "R/Entorno01.R")

# Salvar apenas a estrutura do data.frame
Entorno01 <- Entorno01 %>% head(0)
usethis::use_data(Entorno01, overwrite = TRUE)
