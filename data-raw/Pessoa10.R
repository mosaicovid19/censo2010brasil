library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Pessoa10 <- abrir_base(base = "Pessoa10", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Pessoa10", Pessoa10, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(Pessoa10, add_fields = "source"), "\n"), file = "R/Pessoa10.R")

# Salvar apenas a estrutura do data.frame
Pessoa10 <- Pessoa10 %>% head(0)
usethis::use_data(Pessoa10, overwrite = TRUE)
