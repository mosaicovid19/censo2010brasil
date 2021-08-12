library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

PessoaRenda <- abrir_base(base = "PessoaRenda", cores = cores)

# Salvar apenas a estrutura do data.frame
PessoaRenda <- PessoaRenda %>% head(0)
usethis::use_data(PessoaRenda, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(PessoaRenda, add_fields = "source")
