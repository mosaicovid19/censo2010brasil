library(DBI)

dbfile <- file.path(Sys.getenv("HOME"), "Downloads/Censo2010", "censo2010brasil.sqlite")

test_that("db file integrity", {
  expect(file.size(dbfile), 2269097984)
  # expect_equal(as.character(tools::md5sum(dbfile)), "a34c89945037285bd463b6242233d017")
})

censodb <- dbConnect(
  odbc::odbc(),
  driver = "SQLite3",
  database = dbfile
)

test_that("connection (writable)", {
  expect_true(dbIsValid(censodb))
  expect_false(dbIsReadOnly(censodb))
})

dbDisconnect(censodb)
