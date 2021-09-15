library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

PessoaRenda <- abrir_base(base = "PessoaRenda", censo_dir = censo_dir, cores = cores) %>%
  select(Cod_setor, starts_with("V"))

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "PessoaRenda", PessoaRenda, overwrite = TRUE)

# template de doc (Rd)
cat(paste0(sinew::makeOxygen(PessoaRenda, add_fields = "source"), "\n"), file = "R/PessoaRenda.R")

# Salvar apenas a estrutura do data.frame
PessoaRenda <- PessoaRenda %>% head(0)
usethis::use_data(PessoaRenda, overwrite = TRUE)
