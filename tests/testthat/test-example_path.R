context("example_path")

test_that("extdata remains the same", {
  example_path <- example_path()
  expect_known_output(
    example_path, "ref-example_path", print = TRUE, update = FALSE
  )
})
