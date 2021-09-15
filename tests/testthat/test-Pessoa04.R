library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa04 <- tbl(censodb, "Pessoa04")

test_that("class", {
  expect_s3_class(Pessoa04, "tbl_SQLite")
  expect_s3_class(Pessoa04, "tbl_dbi")
  expect_s3_class(Pessoa04, "tbl_sql")
  expect_s3_class(Pessoa04, "tbl_lazy")
  expect_s3_class(Pessoa04, "tbl")
})

test_that("ncol", {
  expect_equal(
    Pessoa04 %>%
      ncol(),
    156
  )
})

test_that("nrow", {
  expect_equal(
    Pessoa04 %>%
      count() %>%
      pull(),
    310099 # menos setores
  )
})

test_that("names", {
  expect_equal(
    Pessoa04 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Pessoa04 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa04 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Pessoa04 %>%
      select(starts_with("V")) %>%
      ncol(),
    155
  )
})

test_that("keys types", {
  expect_type(
    Pessoa04 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa04 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

test_that("unknown vars", {
  expect_equal(
    Pessoa04 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
