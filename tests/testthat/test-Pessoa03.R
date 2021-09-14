library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa03 <- tbl(censodb, "Pessoa03")

test_that("class", {
  expect_s3_class(Pessoa03, "tbl_SQLite")
  expect_s3_class(Pessoa03, "tbl_dbi")
  expect_s3_class(Pessoa03, "tbl_sql")
  expect_s3_class(Pessoa03, "tbl_lazy")
  expect_s3_class(Pessoa03, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa03),
    c(NA, 253L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa03 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa03 %>%
      colnames() %>%
      length(),
    253
  )
  expect_equal(
    Pessoa03 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa03 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa03 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    251
  )
})

test_that("keys types", {
  expect_type(
    Pessoa03 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa03 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa03 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
