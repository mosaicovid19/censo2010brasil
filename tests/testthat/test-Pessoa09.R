library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa09 <- tbl(censodb, "Pessoa09")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Pessoa09, "tbl_SQLite")
  expect_s3_class(Pessoa09, "tbl_dbi")
  expect_s3_class(Pessoa09, "tbl_sql")
  expect_s3_class(Pessoa09, "tbl_lazy")
  expect_s3_class(Pessoa09, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa09),
    c(NA, 242L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa09 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa09 %>%
      colnames() %>%
      length(),
    242
  )
  expect_equal(
    Pessoa09 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa09 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa09 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    240
  )
})

test_that("keys types", {
  expect_type(
    Pessoa09 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa09 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa09 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
