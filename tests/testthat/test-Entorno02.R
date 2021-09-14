library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno02 <- tbl(censodb, "Entorno02")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Entorno02, "tbl_SQLite")
  expect_s3_class(Entorno02, "tbl_dbi")
  expect_s3_class(Entorno02, "tbl_sql")
  expect_s3_class(Entorno02, "tbl_lazy")
  expect_s3_class(Entorno02, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Entorno02),
    c(NA, 241L)
  )
})

test_that("nrow", {
  expect_identical(
    Entorno02 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Entorno02 %>%
      colnames() %>%
      length(),
    241
  )
  expect_equal(
    Entorno02 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    10
  )
  expect_equal(
    Entorno02 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    9
  )
  expect_equal(
    Entorno02 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    220
  )
})

test_that("keys types", {
  expect_type(
    Entorno02 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Entorno02 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Entorno02 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    19 # Setor_Precoleta + junk
  )
})

dbDisconnect(censodb)
