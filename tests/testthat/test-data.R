context("data")

test_that("data remains unchanged", {
  datasets <- list(
    elevation,
    habitat,
    stem5,
    stem6,
    tree5,
    tree6,
    tree6_3species,
    vft_4quad
  )

  expect_known_output(datasets, "ref-datasets", print = TRUE, update = FALSE)
})

