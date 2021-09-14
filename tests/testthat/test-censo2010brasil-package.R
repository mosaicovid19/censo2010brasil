library(DBI)

dbfile <- file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")

test_that("db file integrity", {
  expect_equal(file.size(dbfile), 2235023360)
  skip("skip MD5SUM (too much time)")
  expect_equal(tools::md5sum(dbfile), "b80e73d8a7d066fdecc545b35d9f0dfc", ignore_attr = TRUE)
})

test_that("connection (writable)", {
  censodb <- dbConnect(
    odbc::odbc(),
    driver = "SQLite3",
    database = dbfile
  )

  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))

  dbDisconnect(censodb)
})

