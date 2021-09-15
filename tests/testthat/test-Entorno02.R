library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno02 <- tbl(censodb, "Entorno02")

test_that("class", {
  expect_s3_class(Entorno02, "tbl_SQLite")
  expect_s3_class(Entorno02, "tbl_dbi")
  expect_s3_class(Entorno02, "tbl_sql")
  expect_s3_class(Entorno02, "tbl_lazy")
  expect_s3_class(Entorno02, "tbl")
})

test_that("ncol", {
  expect_equal(
    Entorno02 %>%
      ncol(),
    221
  )
})

test_that("nrow", {
  expect_equal(
    Entorno02 %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    Entorno02 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Entorno02 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Entorno02 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Entorno02 %>%
      select(starts_with("V")) %>%
      ncol(),
    220
  )
})

test_that("keys types", {
  expect_type(
    Entorno02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Entorno02 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
