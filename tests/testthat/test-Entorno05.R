library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno05 <- tbl(censodb, "Entorno05")

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

test_that("class", {
  expect_s3_class(Entorno05, "tbl_SQLite")
  expect_s3_class(Entorno05, "tbl_dbi")
  expect_s3_class(Entorno05, "tbl_sql")
  expect_s3_class(Entorno05, "tbl_lazy")
  expect_s3_class(Entorno05, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Entorno05),
    c(NA, 256L)
  )
})

test_that("nrow", {
  expect_identical(
    Entorno05 %>%
      count() %>%
      pull(),
    310114L # menos setores
  )
})

test_that("names", {
  expect_equal(
    Entorno05 %>%
      colnames() %>%
      length(),
    256
  )
  expect_equal(
    Entorno05 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    10
  )
  expect_equal(
    Entorno05 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    9
  )
  expect_equal(
    Entorno05 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    220
  )
})

test_that("keys types", {
  expect_type(
    Entorno05 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    Entorno05 %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    Entorno05 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    34 # Setor_Precoleta + junk
  )
})

dbDisconnect(censodb)
