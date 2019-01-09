context("data")

test_that("data remains unchanged", {
  library(fgeo.x)

  pkg <- "fgeo.x"
  datasets_chr <- utils::data(package = pkg)$results[, "Item"]
  datasets <- lapply(datasets_chr, function(x) get(x, asNamespace(pkg)))
  datasets <- stats::setNames(datasets, datasets_chr)
  datasets <- lapply(datasets, function(x) lapply(x, head))

  expect_known_output(datasets, "ref-datasets", print = TRUE, update = T)
})

