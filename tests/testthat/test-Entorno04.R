library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno04 <- tbl(censodb, "Entorno04")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Entorno04, "tbl_SQLite")
  expect_s3_class(Entorno04, "tbl_dbi")
  expect_s3_class(Entorno04, "tbl_sql")
  expect_s3_class(Entorno04, "tbl_lazy")
  expect_s3_class(Entorno04, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Entorno04),
    c(NA, 241L)
  )
})

test_that("nrow", {
  expect_identical(
    Entorno04 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Entorno04 %>%
      colnames() %>%
      length(),
    241
  )
  expect_equal(
    Entorno04 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    10
  )
  expect_equal(
    Entorno04 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    9
  )
  expect_equal(
    Entorno04 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    220
  )
  expect_equal(
    Entorno04 %>%
      select(-starts_with(c("Cod_", "Situacao_Setor", "Nome_", "V"))) %>%
      colnames() %>% length(),
    1 # Setor_Precoleta
  )
})

test_that("keys types", {
  expect_type(
    Entorno04 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Entorno04 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

dbDisconnect(censodb)
