library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno01 <- tbl(censodb, "Entorno01")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Entorno01, "tbl_SQLite")
  expect_s3_class(Entorno01, "tbl_dbi")
  expect_s3_class(Entorno01, "tbl_sql")
  expect_s3_class(Entorno01, "tbl_lazy")
  expect_s3_class(Entorno01, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Entorno01),
    c(NA, 222L)
  )
})

test_that("nrow", {
  expect_identical(
    Entorno01 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Entorno01 %>%
      colnames() %>%
      length(),
    222
  )
  expect_equal(
    Entorno01 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    10
  )
  expect_equal(
    Entorno01 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    9
  )
  expect_equal(
    Entorno01 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    201
  )
})

test_that("keys types", {
  expect_type(
    Entorno01 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Entorno01 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Entorno01 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    19 # Setor_Precoleta + junk
  )
})

dbDisconnect(censodb)
