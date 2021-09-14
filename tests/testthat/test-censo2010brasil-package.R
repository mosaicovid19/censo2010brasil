library(DBI)

dbfile <- file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")

test_that("db file integrity", {
  expect_equal(file.size(dbfile), 2269097984)
  skip("skip MD5SUM (too much time)")
  expect_equal(tools::md5sum(dbfile), "a34c89945037285bd463b6242233d017", ignore_attr = TRUE)
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

