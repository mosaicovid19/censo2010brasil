library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa07 <- tbl(censodb, "Pessoa07")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Pessoa07, "tbl_SQLite")
  expect_s3_class(Pessoa07, "tbl_dbi")
  expect_s3_class(Pessoa07, "tbl_sql")
  expect_s3_class(Pessoa07, "tbl_lazy")
  expect_s3_class(Pessoa07, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa07),
    c(NA, 256L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa07 %>%
      count() %>%
      pull(),
    310077L # menos setores
  )
})

test_that("names", {
  expect_equal(
    Pessoa07 %>%
      colnames() %>%
      length(),
    256
  )
  expect_equal(
    Pessoa07 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa07 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa07 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    204
  )
})

test_that("keys types", {
  expect_type(
    Pessoa07 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa07 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa07 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    50 # junk
  )
})

dbDisconnect(censodb)
