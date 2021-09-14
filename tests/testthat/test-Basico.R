library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

Basico <- tbl(censodb, "Basico")

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
  expect_equal(length(names(Basico)), 33)
  expect_equal(
    Basico %>%
      select(starts_with("Cod_")) %>%
      names() %>% length(),
    10
  )
  expect_equal(
    Basico %>%
      select(starts_with("Nome_")) %>%
      names() %>% length(),
    9
  )
  expect_equal(
    Basico %>%
      select(starts_with("V")) %>%
      names() %>% length(),
    12
  )
  expect_equal(
    Basico %>%
      select(-starts_with(c("Cod_", "Nome_", "V"))) %>%
      names() %>% length(),
    2
  )
})

dbDisconnect(censodb)
