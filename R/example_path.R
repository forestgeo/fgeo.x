#' Get path to file or directory containing example data.
#'
#' @param path Name of file or directory. If `NULL`, the example files and
#'   directories will be listed.
#'
#' @return A string giving a path to an example.
#'
#' @examples
#' example_path()
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
