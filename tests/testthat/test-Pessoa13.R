library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa13 <- tbl(censodb, "Pessoa13")

test_that("class", {
  expect_s3_class(Pessoa13, "tbl_SQLite")
  expect_s3_class(Pessoa13, "tbl_dbi")
  expect_s3_class(Pessoa13, "tbl_sql")
  expect_s3_class(Pessoa13, "tbl_lazy")
  expect_s3_class(Pessoa13, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa13),
    c(NA, 135L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa13 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa13 %>%
      ncol(),
    135
  )
  expect_equal(
    Pessoa13 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa13 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa13 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa13 %>%
      select(starts_with("V")) %>%
      ncol(),
    134
  )
})

test_that("keys types", {
  expect_type(
    Pessoa13 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa13 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
