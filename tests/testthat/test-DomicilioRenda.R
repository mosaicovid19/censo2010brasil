library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

DomicilioRenda <- tbl(censodb, "DomicilioRenda")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(DomicilioRenda, "tbl_SQLite")
  expect_s3_class(DomicilioRenda, "tbl_dbi")
  expect_s3_class(DomicilioRenda, "tbl_sql")
  expect_s3_class(DomicilioRenda, "tbl_lazy")
  expect_s3_class(DomicilioRenda, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(DomicilioRenda),
    c(NA, 16L)
  )
})

test_that("nrow", {
  expect_identical(
    DomicilioRenda %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    DomicilioRenda %>%
      colnames() %>%
      length(),
    16
  )
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    14
  )
})

test_that("keys types", {
  expect_type(
    DomicilioRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    DomicilioRenda %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    DomicilioRenda %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
