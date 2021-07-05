library(tidyverse)
library(readxl)
# library(janitor)
library(future.apply)

censo_dir <- file.path("~/Downloads/Censo2010")
censo_dw <- file.path(censo_dir, "zips")

# estados_zip <- list(
#   CE = "CE_20171016.zip"
#   , DF = "DF_20171016.zip"
#   , MG = "MG_20171016.zip"
#   , RS = "RS_20171016.zip"
#   , TO = "TO_20171016.zip"
#   , ES = "ES_20171016.zip"
#   , RJ = "RJ_20171016.zip"
#   , SP1 = "SP_Capital_20190823.zip"
#   , SP2 = "SP_Exceto_a_Capital_20190207.zip"
# )


estados_zip <- list(
  AC = "AC_20171016.zip",
  AL = "AL_20171016.zip",
  AM = "AM_20171016.zip",
  AP = "AP_20171016.zip",
  BA = "BA_20171016.zip",
  CE = "CE_20171016.zip",
  DF = "DF_20171016.zip",
  ES = "ES_20171016.zip",
  GO = "GO_20171016.zip",
  MA = "MA_20171016.zip",
  MG = "MG_20171016.zip",
  MS = "MS_20171016.zip",
  MT = "MT_20171016.zip",
  PA = "PA_20171016.zip",
  PB = "PB_20171016.zip",
  PE = "PE_20200219.zip",
  PI = "PI_20171016.zip",
  RJ = "RJ_20171016.zip",
  RS = "RS_20171016.zip",
  SP1 = "SP_Capital_20190823.zip",
  SP2 = "SP_Exceto_a_Capital_20190207.zip",
  TO = "TO_20171016.zip"
)


plan(cluster)

future_lapply(estados_zip,
       function (f) {
         unzip(
           file.path(censo_dw, f),
           exdir = censo_dir,
           junkpaths = TRUE)
         })

plan(sequential)

