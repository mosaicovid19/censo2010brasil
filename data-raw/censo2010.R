## code to prepare `censo2010` dataset goes here

library(tidyverse)

## localização dos dados brutos
if(!exists("censo_dir")) censo_dir <- file.path("~/Downloads/Censo2010")

# num de cores para usar em paralelo
# não é recomendado usar muitos cores, devido ao tamanho das bases
if(!exists("cores")) cores <- 1

source("data-raw/Basico.R", encoding = 'UTF-8')
source("data-raw/Domicilio01.R", encoding = 'UTF-8')
source("data-raw/Domicilio02.R", encoding = 'UTF-8')
source("data-raw/DomicilioRenda.R", encoding = 'UTF-8')
source("data-raw/Entorno03.R", encoding = 'UTF-8')
source("data-raw/Pessoa03.R", encoding = 'UTF-8')
source("data-raw/Responsavel02.R", encoding = 'UTF-8')
