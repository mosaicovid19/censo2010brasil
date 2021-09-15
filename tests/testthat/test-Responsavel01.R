library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Responsavel01 <- tbl(censodb, "Responsavel01")

test_that("class", {
  expect_s3_class(Responsavel01, "tbl_SQLite")
  expect_s3_class(Responsavel01, "tbl_dbi")
  expect_s3_class(Responsavel01, "tbl_sql")
  expect_s3_class(Responsavel01, "tbl_lazy")
  expect_s3_class(Responsavel01, "tbl")
})

test_that("ncol", {
  expect_equal(
    Responsavel01 %>%
      ncol(),
    109
  )
})

test_that("nrow", {
  expect_equal(
    Responsavel01 %>%
      count() %>%
      pull(),
    310114 # menos setores
  )
})

test_that("names", {
  expect_equal(
    Responsavel01 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Responsavel01 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Responsavel01 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Responsavel01 %>%
      select(starts_with("V")) %>%
      ncol(),
    108
  )
})

test_that("keys types", {
  expect_type(
    Responsavel01 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Responsavel01 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
