library(censo2010brasil)
library(DBI)
dbfile <- file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
censodb <- dbConnect(odbc::odbc(), driver = "SQLite3", database = dbfile)

dbDisconnect(censodb)
detach("package:censo2010brasil", unload = TRUE)
