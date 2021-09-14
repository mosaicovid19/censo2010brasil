library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Domicilio02 <- abrir_base(base = "Domicilio02", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Domicilio02", Domicilio02)

# Salvar apenas a estrutura do data.frame
Domicilio02 <- Domicilio02 %>% head(0)
usethis::use_data(Domicilio02, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Domicilio02, add_fields = "source")
