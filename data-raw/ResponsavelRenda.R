library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

ResponsavelRenda <- abrir_base(base = "ResponsavelRenda", cores = cores)

# Injetar data.frame em tabela do DB
dbWriteTable(con, "ResponsavelRenda", ResponsavelRenda)

# Salvar apenas a estrutura do data.frame
ResponsavelRenda <- ResponsavelRenda %>% head(0)
usethis::use_data(ResponsavelRenda, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(ResponsavelRenda, add_fields = "source")
