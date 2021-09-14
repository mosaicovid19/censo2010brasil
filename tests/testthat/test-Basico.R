library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Basico <- tbl(censodb, "Basico")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Basico, "tbl_SQLite")
  expect_s3_class(Basico, "tbl_dbi")
  expect_s3_class(Basico, "tbl_sql")
  expect_s3_class(Basico, "tbl_lazy")
  expect_s3_class(Basico, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Basico),
    c(NA, 33L)
  )
})

test_that("nrow", {
  expect_identical(
    Basico %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Basico %>%
      colnames() %>%
      length(),
    33
  )
  expect_equal(
    Basico %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    10
  )
  expect_equal(
    Basico %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    9
  )
  expect_equal(
    Basico %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    12
  )
  expect_equal(
    Basico %>%
      select(-starts_with(c("Cod_", "Situacao_Setor", "Nome_", "V"))) %>%
      colnames() %>% length(),
    1 # Tipo_Setor
  )
})

test_that("keys types", {
  expect_type(
    Basico %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Basico %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

dbDisconnect(censodb)
