library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Responsavel02 <- tbl(censodb, "Responsavel02")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Responsavel02, "tbl_SQLite")
  expect_s3_class(Responsavel02, "tbl_dbi")
  expect_s3_class(Responsavel02, "tbl_sql")
  expect_s3_class(Responsavel02, "tbl_lazy")
  expect_s3_class(Responsavel02, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Responsavel02),
    c(NA, 218L)
  )
})

test_that("nrow", {
  expect_identical(
    Responsavel02 %>%
      count() %>%
      pull(),
    310114L
  )
})

test_that("names", {
  expect_equal(
    Responsavel02 %>%
      colnames() %>%
      length(),
    218
  )
  expect_equal(
    Responsavel02 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Responsavel02 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Responsavel02 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    216
  )

})

test_that("keys types", {
  expect_type(
    Responsavel02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Responsavel02 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Responsavel02 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
