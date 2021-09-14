library(DBI)
censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")
)

ResponsavelRenda <- tbl(censodb, "ResponsavelRenda")

test_that("class", {
  expect_s3_class(ResponsavelRenda, "tbl_SQLite")
  expect_s3_class(ResponsavelRenda, "tbl_dbi")
  expect_s3_class(ResponsavelRenda, "tbl_sql")
  expect_s3_class(ResponsavelRenda, "tbl_lazy")
  expect_s3_class(ResponsavelRenda, "tbl")
})

test_that("dimensions", {
  expect_identical(
    dim(ResponsavelRenda),
    c(NA, 134L)
  )
})

test_that("nrow", {
  expect_identical(
    ResponsavelRenda %>%
      count() %>%
      pull(),
    310120L
  )
})

test_that("names", {
  expect_equal(
    ResponsavelRenda %>%
      colnames() %>%
      length(),
    134
  )
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("Cod_")) %>%
      colnames() %>% length(),
    1
  )
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("Nome_")) %>%
      colnames() %>% length(),
    0
  )
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("V")) %>%
      colnames() %>% length(),
    132
  )

})

test_that("keys types", {
  expect_type(
    ResponsavelRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "double")
  expect_type(
    ResponsavelRenda %>%
      select(Situacao_setor) %>%
      head() %>%
      pull(),
    "double")
})

test_that("unknown vars", {
  expect_equal(
    ResponsavelRenda %>%
      select(-starts_with("V"), -Cod_setor, -Situacao_setor) %>%
      colnames() %>% length(),
    0
  )
})

dbDisconnect(censodb)
