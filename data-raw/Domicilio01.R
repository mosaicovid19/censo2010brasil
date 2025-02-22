library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Domicilio01 <- abrir_base(base = "Domicilio01", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Domicilio01", Domicilio01, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Domicilio01, add_fields = "source"), "\n"), file = "R/Domicilio01.R")

# Salvar apenas a estrutura do data.frame
Domicilio01 <- Domicilio01 %>% head(0)
usethis::use_data(Domicilio01, overwrite = TRUE)
