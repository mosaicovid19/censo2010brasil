library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path(paste0(Sys.getenv("HOME"), "/Downloads/Censo2010/"))

if(!exists("cores")) cores <- 1

Basico <- abrir_base(base = "Basico", censo_dir = censo_dir, cores = cores) %>%
  mutate(
    # Cod_setor é tratado em abrir_base_estado()
    Situacao_setor = as.integer(Situacao_setor),
    `Cod_Grandes Regiões` = as.integer(`Cod_Grandes Regiões`),
    Cod_UF = as.integer(Cod_UF),
    Cod_meso = as.integer(Cod_meso),
    Cod_micro = as.integer(Cod_micro),
    Cod_RM = as.integer(Cod_RM),
    Cod_municipio = as.integer(Cod_municipio),
    Cod_distrito = as.integer(Cod_distrito),
    # Cod_subdistrito excede o limite de int, precisamos int64
    Cod_subdistrito = bit64::as.integer64(Cod_subdistrito),
    Cod_bairro = as.integer(Cod_micro),
  )

# Injetar data.frame em tabela do DB
dbWriteTable(censodb, "Basico", Basico)

# Salvar apenas a estrutura do data.frame
Basico <- Basico %>% head(0)
usethis::use_data(Basico, overwrite = TRUE)

# template de doc (Rd)
sinew::makeOxygen(Basico, add_fields = "source")
