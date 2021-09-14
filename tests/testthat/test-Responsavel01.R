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

test_that("dimensions", {
  expect_identical(
    dim(Responsavel01),
    c(NA, 109L)
  )
})

test_that("nrow", {
  expect_identical(
    Responsavel01 %>%
      count() %>%
      pull(),
    310114L # menos setores
  )
})

test_that("names", {
  expect_equal(
    Responsavel01 %>%
      colnames() %>%
      length(),
    109
  )
  expect_equal(
    Responsavel01 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Responsavel01 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Responsavel01 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
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
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
