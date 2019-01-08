context("data")

test_that("data remains unchanged", {
  library(fgeo.x)
  pkg <- "fgeo.x"

  datasets_chr <- utils::data(package = pkg)$results[, "Item"]
  datasets <- datasets_chr %>%
    lapply(function(.x) get(.x, asNamespace(pkg))) %>%
    stats::setNames(datasets_chr) %>%
    # head of each list item
    lapply(head)

  expect_known_output(datasets, "ref-datasets", print = TRUE, update = TRUE)
})
