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
source("data-raw/Entorno01.R", encoding = 'UTF-8')
source("data-raw/Entorno02.R", encoding = 'UTF-8')
source("data-raw/Entorno03.R", encoding = 'UTF-8')
source("data-raw/Entorno04.R", encoding = 'UTF-8')
source("data-raw/Entorno05.R", encoding = 'UTF-8')
source("data-raw/Pessoa01.R", encoding = 'UTF-8')
source("data-raw/Pessoa02.R", encoding = 'UTF-8')
source("data-raw/Pessoa03.R", encoding = 'UTF-8')
source("data-raw/Pessoa04.R", encoding = 'UTF-8')
source("data-raw/Pessoa05.R", encoding = 'UTF-8')
source("data-raw/Pessoa06.R", encoding = 'UTF-8')
source("data-raw/Pessoa07.R", encoding = 'UTF-8')
source("data-raw/Pessoa08.R", encoding = 'UTF-8')
source("data-raw/Pessoa09.R", encoding = 'UTF-8')
source("data-raw/Pessoa10.R", encoding = 'UTF-8')
source("data-raw/Pessoa11.R", encoding = 'UTF-8')
source("data-raw/Pessoa12.R", encoding = 'UTF-8')
source("data-raw/Pessoa13.R", encoding = 'UTF-8')
source("data-raw/PessoaRenda.R", encoding = 'UTF-8')
source("data-raw/Responsavel01.R", encoding = 'UTF-8')
source("data-raw/Responsavel02.R", encoding = 'UTF-8')
source("data-raw/ResponsavelRenda.R", encoding = 'UTF-8')
