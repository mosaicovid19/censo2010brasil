library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Entorno04 <- tbl(censodb, "Entorno04")

test_that("class", {
  expect_s3_class(Entorno04, "tbl_SQLite")
  expect_s3_class(Entorno04, "tbl_dbi")
  expect_s3_class(Entorno04, "tbl_sql")
  expect_s3_class(Entorno04, "tbl_lazy")
  expect_s3_class(Entorno04, "tbl")
})

test_that("ncol", {
  expect_equal(
    Entorno04 %>%
      ncol(),
    221
  )
})

test_that("nrow", {
  expect_equal(
    Entorno04 %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    Entorno04 %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    Entorno04 %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    Entorno04 %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    Entorno04 %>%
      select(starts_with("V")) %>%
      ncol(),
    220
  )
})

test_that("keys types", {
  expect_type(
    Entorno04 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Entorno04 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

test_that("unknown vars", {
  expect_equal(
    Entorno04 %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    19 # Setor_Precoleta + junk
  )
})

dbDisconnect(censodb)
