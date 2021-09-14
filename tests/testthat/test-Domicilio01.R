library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Domicilio01 <- tbl(censodb, "Domicilio01")

test_that("class", {
  expect_s3_class(Domicilio01, "tbl_SQLite")
  expect_s3_class(Domicilio01, "tbl_dbi")
  expect_s3_class(Domicilio01, "tbl_sql")
  expect_s3_class(Domicilio01, "tbl_lazy")
  expect_s3_class(Domicilio01, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Domicilio01),
    c(NA, 242L)
  )
})

test_that("nrow", {
  expect_identical(
    Domicilio01 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Domicilio01 %>%
      colnames() %>%
      length(),
    242
  )
  expect_equal(
    Domicilio01 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Domicilio01 %>%
      select(matches("Situacao_setor")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Domicilio01 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Domicilio01 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    241
  )
})

test_that("keys types", {
  expect_type(
    Domicilio01 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Domicilio01 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
