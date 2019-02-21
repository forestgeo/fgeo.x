context("download_data")

has_internet <- function() {
  z <- try(suppressWarnings(readLines('https://www.google.com', n = 1)),
      silent = TRUE)
  ! inherits(z, "try-error")
}

skip_if_net_down <- function() {
  if (has_internet()) {
    return()
  }
  testthat::skip("no internet")
}

test_that("download_data with `destfile = NULL` it reads data", {
  skip_if_net_down()
  expect_is(download_data("unique_id"), "data.frame")
})

test_that("download_data with non-NULL `destfile` downloads to `destfile`", {
  tmp <- tempfile()
  on.exit(rm(tmp))
  download_data("unique_id", destfile = tmp)
  load(tmp)
  expect_is(unique_id, "data.frame")
})
