#' Access data stored online.
#'
#' @param .data A string giving the name of the dataset to download. The name of
#'   any dataset listed [here](
#'   https://github.com/forestgeo/fgeo.data/tree/master/data) (without the
#'   extension).
#'
#' @return A dataset.
#'
#' @examples
#' \dontrun{
#' # May take over 5 seconds (i.e. above the time limit acceptable for CRAN)
#' download_data("luquillo_stem6_random")
#' }
#' @family datasets
#' @export
download_data <- function(.data) {
  tmp <- tempfile()
  utils::download.file(data_url(.data), tmp)

  e <- new.env()
  load(tmp, envir = e)

  e[[.data]]
}

data_url <- function(x) {
  paste0("https://github.com/forestgeo/fgeo.data/raw/master/data/", x, ".rda")
}
