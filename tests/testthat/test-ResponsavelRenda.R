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

test_that("ncol", {
  expect_equal(
    ResponsavelRenda %>%
      ncol(),
    133
  )
})

test_that("nrow", {
  expect_equal(
    ResponsavelRenda %>%
      count() %>%
      pull(),
    310120
  )
})

test_that("names", {
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("Cod_")) %>%
      ncol(),
    1
  )
  expect_equal(
    ResponsavelRenda %>%
      select(matches("Situacao_setor")) %>%
      ncol(),
    0
  )
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("Nome_")) %>%
      ncol(),
    0
  )
  expect_equal(
    ResponsavelRenda %>%
      select(starts_with("V")) %>%
      ncol(),
    132
  )

})

test_that("keys types", {
  expect_type(
    ResponsavelRenda %>%
      select(Cod_setor) %>%
      head() %>%
      pull(),
    "character")
})

test_that("unknown vars", {
  expect_equal(
    ResponsavelRenda %>%
      select(-starts_with("V"), -Cod_setor) %>%
      ncol(),
    0
  )
})

dbDisconnect(censodb)
