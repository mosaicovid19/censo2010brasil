library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno04 <- abrir_base(base = "Entorno04", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Entorno04", Entorno04, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Entorno04, add_fields = "source"), "\n"), file = "R/Entorno04.R")

# Salvar apenas a estrutura do data.frame
Entorno04 <- Entorno04 %>% head(0)
usethis::use_data(Entorno04, overwrite = TRUE)
