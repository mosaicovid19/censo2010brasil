library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Domicilio02 <- tbl(censodb, "Domicilio02")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Domicilio02, "tbl_SQLite")
  expect_s3_class(Domicilio02, "tbl_dbi")
  expect_s3_class(Domicilio02, "tbl_sql")
  expect_s3_class(Domicilio02, "tbl_lazy")
  expect_s3_class(Domicilio02, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Domicilio02),
    c(NA, 134L)
  )
})

test_that("nrow", {
  expect_identical(
    Domicilio02 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Domicilio02 %>%
      colnames() %>%
      length(),
    134
  )
  expect_equal(
    Domicilio02 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Domicilio02 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Domicilio02 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    132
  )
})

test_that("keys types", {
  expect_type(
    Domicilio02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Domicilio02 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Domicilio02 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
