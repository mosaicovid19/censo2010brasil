library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa06 <- tbl(censodb, "Pessoa06")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Pessoa06, "tbl_SQLite")
  expect_s3_class(Pessoa06, "tbl_dbi")
  expect_s3_class(Pessoa06, "tbl_sql")
  expect_s3_class(Pessoa06, "tbl_lazy")
  expect_s3_class(Pessoa06, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa06),
    c(NA, 215L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa06 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa06 %>%
      colnames() %>%
      length(),
    215
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    213
  )
  expect_equal(
    Pessoa06 %>%
      select(-starts_with(c("Cod_", "Situacao_Setor", "Nome_", "V"))) %>%
      colnames() %>% length(),
    0
  )
})

test_that("keys types", {
  expect_type(
    Pessoa06 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa06 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

dbDisconnect(censodb)

