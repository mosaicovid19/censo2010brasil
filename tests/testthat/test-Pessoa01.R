library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa01 <- tbl(censodb, "Pessoa01")

test_that("class", {
  expect_s3_class(Pessoa01, "tbl_SQLite")
  expect_s3_class(Pessoa01, "tbl_dbi")
  expect_s3_class(Pessoa01, "tbl_sql")
  expect_s3_class(Pessoa01, "tbl_lazy")
  expect_s3_class(Pessoa01, "tbl")
})

test_that("ncol", {
  expect_equal(
    Pessoa01 %>%
      ncol(),
    86
  )
})

test_that("nrow", {
  expect_equal(
    Pessoa01 %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    Pessoa01 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa01 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa01 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa01 %>%
      select(starts_with("V")) %>%
      ncol(),
    85
  )
})

test_that("keys types", {
  expect_type(
    Pessoa01 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa01 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

test_that("unknown vars", {
  expect_equal(
    Pessoa01 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
