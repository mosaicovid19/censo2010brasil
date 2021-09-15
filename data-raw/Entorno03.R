library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Entorno03 <- abrir_base(base = "Entorno03", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Entorno03", Entorno03, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Entorno03, add_fields = "source")

# Salvar apenas a estrutura do data.frame
Entorno03 <- Entorno03 %>% head(0)
usethis::use_data(Entorno03, overwrite = TRUE)
