#' Download data from fgeo.data.
#'
#' @param .data A string giving the name of the dataset to download. The name of
#'   any dataset listed [here](
#'   https://github.com/forestgeo/fgeo.data/tree/master/data) (without the
#'   extension).
#'
#' @return A dataset.
#' @export
#'
#' @examples
#' download_data("unique_id")
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
