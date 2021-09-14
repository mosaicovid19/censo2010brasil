library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa10 <- tbl(censodb, "Pessoa10")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Pessoa10, "tbl_SQLite")
  expect_s3_class(Pessoa10, "tbl_dbi")
  expect_s3_class(Pessoa10, "tbl_sql")
  expect_s3_class(Pessoa10, "tbl_lazy")
  expect_s3_class(Pessoa10, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa10),
    c(NA, 5L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa10 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa10 %>%
      colnames() %>%
      length(),
    5
  )
  expect_equal(
    Pessoa10 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa10 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa10 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    3
  )
})

test_that("keys types", {
  expect_type(
    Pessoa10 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa10 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa10 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
