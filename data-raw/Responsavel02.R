library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Responsavel02 <- abrir_base(base = "Responsavel02", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "Responsavel02", Responsavel02)

# Salvar apenas a estrutura do data.frame
Responsavel02 <- Responsavel02 %>% head(0)
usethis::use_data(Responsavel02, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Responsavel02, add_fields = "source")
