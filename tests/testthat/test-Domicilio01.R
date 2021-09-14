library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

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
    c(NA, 33L)
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
  expect_equal(length(names(Domicilio01)), 33)
  expect_equal(
    Domicilio01 %>%
      select(starts_with("Cod_")) %>%
      names() %>% length(),
    10
  )
  expect_equal(
    Domicilio01 %>%
      select(starts_with("Nome_")) %>%
      names() %>% length(),
    9
  )
  expect_equal(
    Domicilio01 %>%
      select(starts_with("V")) %>%
      names() %>% length(),
    12
  )
  expect_equal(
    Domicilio01 %>%
      select(-starts_with(c("Cod_", "Nome_", "V"))) %>%
      names() %>% length(),
    2
  )
})

test_that("keys types", {
  expect_type(Domicilio01$Cod_setor, "double")
  expect_type(Domicilio01$Situacao_setor, "double")
})

dbDisconnect(censodb)
