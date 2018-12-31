context("example_path")

expect_printed_output <- function(object, update = FALSE) {
  file <- rlang::quo_text(rlang::enquo(object))

  testthat::expect_known_output(
    object, paste0("ref-", file),
    print = TRUE, update = update
  )

  invisible(object)
}

test_that("extdata remains the same", {
  expect_printed_output(example_path())
})
