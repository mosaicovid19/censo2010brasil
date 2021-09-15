library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Responsavel02 <- tbl(censodb, "Responsavel02")

test_that("class", {
  expect_s3_class(Responsavel02, "tbl_SQLite")
  expect_s3_class(Responsavel02, "tbl_dbi")
  expect_s3_class(Responsavel02, "tbl_sql")
  expect_s3_class(Responsavel02, "tbl_lazy")
  expect_s3_class(Responsavel02, "tbl")
})

test_that("ncol", {
  expect_equal(
    Responsavel02 %>%
      ncol(),
    217
  )
})

test_that("nrow", {
  expect_equal(
    Responsavel02 %>%
      count() %>%
      pull(),
    310114 # menos setores
  )
})

test_that("names", {
  expect_equal(
    Responsavel02 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Responsavel02 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Responsavel02 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Responsavel02 %>%
      select(starts_with("V")) %>%
      ncol(),
    216
  )

})

test_that("keys types", {
  expect_type(
    Responsavel02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Responsavel02 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
