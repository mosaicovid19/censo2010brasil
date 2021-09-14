library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa04 <- tbl(censodb, "Pessoa04")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Pessoa04, "tbl_SQLite")
  expect_s3_class(Pessoa04, "tbl_dbi")
  expect_s3_class(Pessoa04, "tbl_sql")
  expect_s3_class(Pessoa04, "tbl_lazy")
  expect_s3_class(Pessoa04, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa04),
    c(NA, 157L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa04 %>%
      count() %>%
      pull(),
    310099L # menos setores
  )
})

test_that("names", {
  expect_equal(
    Pessoa04 %>%
      colnames() %>%
      length(),
    157
  )
  expect_equal(
    Pessoa04 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa04 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa04 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    155
  )
  expect_equal(
    Pessoa04 %>%
      select(-starts_with(c("Cod_", "Situacao_Setor", "Nome_", "V"))) %>%
      colnames() %>% length(),
    0
  )
})

test_that("keys types", {
  expect_type(
    Pessoa04 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Pessoa04 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

dbDisconnect(censodb)
