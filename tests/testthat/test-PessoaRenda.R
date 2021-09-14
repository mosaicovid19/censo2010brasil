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
    c(NA, 134L)
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
      colnames() %>%
      length(),
    134
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    PessoaRenda %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    132
  )
})

test_that("keys types", {
  expect_type(
    PessoaRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    PessoaRenda %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    PessoaRenda %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
