library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Basico <- tbl(censodb, "Basico")

test_that("class", {
  expect_s3_class(Basico, "tbl_SQLite")
  expect_s3_class(Basico, "tbl_dbi")
  expect_s3_class(Basico, "tbl_sql")
  expect_s3_class(Basico, "tbl_lazy")
  expect_s3_class(Basico, "tbl")
})

test_that("ncol", {
  expect_equal(
    Basico %>%
      ncol(),
    33
  )
})

test_that("nrow", {
  expect_equal(
    Basico %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    Basico %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    10
  )
  expect_equal(
    Basico %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    1
  )
  expect_equal(
    Basico %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    9
  )
  expect_equal(
    Basico %>%
      select(starts_with("V")) %>%
      ncol(),
    12
  )
})

test_that("keys types", {
  expect_type(
    Basico %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
  expect_type(
    Basico %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "integer")
})

test_that("unknown vars", {
  expect_equal(
    Basico %>%
      select(-starts_with(c("Cod_", "Nome_", "V")), -Situacao_setor, -Tipo_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
