library(censo2010brasil)
library(DBI)
con <- dbConnect(odbc::odbc(), driver = "SQLite3", database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite"))

dbDisconnect(con)
detach("package:censo2010brasil", unload = TRUE)
