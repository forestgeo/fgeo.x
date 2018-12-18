expect_printed_output <- function(object, update = FALSE) {
  file <- rlang::quo_text(rlang::enquo(object))

  testthat::expect_known_output(
    object, paste0("ref-", file),
    print = TRUE, update = update
  )

  invisible(object)
}



context("data")

test_that("data remains unchanged", {
  library(fgeo.x)
  pkg <- "fgeo.x"
  datasets_chr <- handy::pkg_datasets_chr(pkg)
  datasets <- datasets_chr %>%
    purrr::map(~handy::pkg_get(.x, pkg)) %>%
    purrr::set_names(datasets_chr) %>%
    purrr::map_if(is.data.frame, tibble::as.tibble) %>%
    # head of each list item
    purrr::map_if(Negate(is.data.frame), ~purrr::map(.x, head))

  expect_printed_output(datasets)
})

