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
