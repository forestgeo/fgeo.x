#' Path to directory containing example data.
#'
#' @param path Path to a file (with extension) from inst/extdata/
#'
#' @return A string giving a path to an example.
#'
#' @examples
#' dir(x_example())
#' read.csv(x_example("taxa.csv"))[1:5, 1:5]
#'
#' @family datasets
#' @export
x_example <- function (path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "fgeo.x"))
  }
  else {
    system.file("extdata", path, package = "fgeo.x", mustWork = TRUE)
  }
}
