library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa10 <- tbl(censodb, "Pessoa10")

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
    c(NA, 4L)
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
    4
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
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa10 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
