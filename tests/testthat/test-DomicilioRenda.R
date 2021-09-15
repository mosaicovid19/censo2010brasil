library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

DomicilioRenda <- tbl(censodb, "DomicilioRenda")

test_that("class", {
  expect_s3_class(DomicilioRenda, "tbl_SQLite")
  expect_s3_class(DomicilioRenda, "tbl_dbi")
  expect_s3_class(DomicilioRenda, "tbl_sql")
  expect_s3_class(DomicilioRenda, "tbl_lazy")
  expect_s3_class(DomicilioRenda, "tbl")
})

test_that("ncol", {
  expect_equal(
    DomicilioRenda %>%
      ncol(),
    15
  )
})

test_that("nrow", {
  expect_equal(
    DomicilioRenda %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    DomicilioRenda %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    DomicilioRenda %>%
      select(starts_with("V")) %>%
      ncol(),
    14
  )
})

test_that("keys types", {
  expect_type(
    DomicilioRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    DomicilioRenda %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
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
