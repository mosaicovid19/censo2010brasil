library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

Pessoa06 <- tbl(censodb, "Pessoa06")

test_that("class", {
  expect_s3_class(Pessoa06, "tbl_SQLite")
  expect_s3_class(Pessoa06, "tbl_dbi")
  expect_s3_class(Pessoa06, "tbl_sql")
  expect_s3_class(Pessoa06, "tbl_lazy")
  expect_s3_class(Pessoa06, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(Pessoa06),
    c(NA, 214L)
  )
})

test_that("nrow", {
  expect_identical(
    Pessoa06 %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    Pessoa06 %>%
      colnames() %>%
      length(),
    214
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    Pessoa06 %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    213
  )
})

test_that("keys types", {
  expect_type(
    Pessoa06 %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    Pessoa06 %>%
      select(-starts_with("V"), -Cod_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
