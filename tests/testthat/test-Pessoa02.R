library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa02 <- tbl(censodb, "Pessoa02")

test_that("class", {
  expect_s3_class(Pessoa02, "tbl_SQLite")
  expect_s3_class(Pessoa02, "tbl_dbi")
  expect_s3_class(Pessoa02, "tbl_sql")
  expect_s3_class(Pessoa02, "tbl_lazy")
  expect_s3_class(Pessoa02, "tbl")
})

test_that("ncol", {
  expect_equal(
    Pessoa02 %>%
      ncol(),
    171
  )
})

test_that("nrow", {
  expect_equal(
    Pessoa02 %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    Pessoa02 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa02 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa02 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa02 %>%
      select(starts_with("V")) %>%
      ncol(),
    170
  )
})

test_that("keys types", {
  expect_type(
    Pessoa02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa02 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
