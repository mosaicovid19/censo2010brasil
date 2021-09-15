library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa07 <- tbl(censodb, "Pessoa07")

test_that("class", {
  expect_s3_class(Pessoa07, "tbl_SQLite")
  expect_s3_class(Pessoa07, "tbl_dbi")
  expect_s3_class(Pessoa07, "tbl_sql")
  expect_s3_class(Pessoa07, "tbl_lazy")
  expect_s3_class(Pessoa07, "tbl")
})

test_that("ncol", {
  expect_equal(
    Pessoa07 %>%
      ncol(),
    205
  )
})

test_that("nrow", {
  expect_equal(
    Pessoa07 %>%
      count() %>%
      pull(),
    310077 # menos setores
  )
})

test_that("names", {
  expect_equal(
    Pessoa07 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa07 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa07 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa07 %>%
      select(starts_with("V")) %>%
      ncol(),
    204
  )
})

test_that("keys types", {
  expect_type(
    Pessoa07 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa07 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
