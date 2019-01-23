#' Access data stored in system files.
#'
#' `example_path()` mostly wraps `system.file(..., package = "fgeo.x")`.
#'
#' @param path Name of file or directory. If `NULL`, the example files and
#'   directories will be listed.
#'
#' @return A character string.
#'
#' @examples
#' example_path()
#'
#' dir(example_path("rdata"))
#'
#' example_path("taxa.csv")
#'
#' str(read.csv(example_path("taxa.csv")))
#' @family datasets
#' @export
example_path <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "fgeo.x"))
  }
  else {
    system.file("extdata", path, package = "fgeo.x", mustWork = TRUE)
  }
}
