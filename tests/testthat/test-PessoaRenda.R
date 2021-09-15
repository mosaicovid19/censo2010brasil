library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

PessoaRenda <- tbl(censodb, "PessoaRenda")

test_that("class", {
  expect_s3_class(PessoaRenda, "tbl_SQLite")
  expect_s3_class(PessoaRenda, "tbl_dbi")
  expect_s3_class(PessoaRenda, "tbl_sql")
  expect_s3_class(PessoaRenda, "tbl_lazy")
  expect_s3_class(PessoaRenda, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(PessoaRenda),
    c(NA, 133L)
  )
})

test_that("nrow", {
  expect_identical(
    PessoaRenda %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    PessoaRenda %>%
      ncol(),
    133
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    PessoaRenda %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("V")) %>%
      ncol(),
    132
  )
})

test_that("keys types", {
  expect_type(
    PessoaRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    PessoaRenda %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
