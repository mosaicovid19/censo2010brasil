library(DBI)

dbfile <- file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")

test_that("db file integrity", {
  expect_equal(file.size(dbfile), 2243100672)
  # skip("skip MD5SUM (too much time)")
  expect_equal(tools::md5sum(dbfile), "8d6d2262ef769a23c5b7db414ba0191d", ignore_attr = TRUE)
})

## Connect to db
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = dbfile
)

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("Tables", {
  expect_equal(
    dbListTables(censodb) %>% length(),
    26
  )
  expect_equal(
    dbListTables(censodb) %>% sort(),
    c("Basico", "Domicilio01", "Domicilio02", "DomicilioRenda", "Entorno01",
      "Entorno02", "Entorno03", "Entorno04", "Entorno05", "Pessoa01",
      "Pessoa02", "Pessoa03", "Pessoa04", "Pessoa05", "Pessoa06", "Pessoa07",
      "Pessoa08", "Pessoa09", "Pessoa10", "Pessoa11", "Pessoa12", "Pessoa13",
      "PessoaRenda", "Responsavel01", "Responsavel02", "ResponsavelRenda"
    )
  )
})

## Disconnect from db
dbDisconnect(censodb)
