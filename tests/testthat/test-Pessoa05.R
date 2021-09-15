library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa05 <- tbl(censodb, "Pessoa05")

test_that("class", {
  expect_s3_class(Pessoa05, "tbl_SQLite")
  expect_s3_class(Pessoa05, "tbl_dbi")
  expect_s3_class(Pessoa05, "tbl_sql")
  expect_s3_class(Pessoa05, "tbl_lazy")
  expect_s3_class(Pessoa05, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa05),
    c(NA, 11L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa05 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa05 %>%
      ncol(),
    11
  )
  expect_equal(
    Pessoa05 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa05 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa05 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa05 %>%
      select(starts_with("V")) %>%
      ncol(),
    10
  )
})

test_that("keys types", {
  expect_type(
    Pessoa05 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa05 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
