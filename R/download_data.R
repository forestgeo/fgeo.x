download_data_impl <- function(x, destfile = NULL) {
  if (!is.null(destfile)) {
    return(utils::download.file(data_url(x), destfile = destfile))
  }

  tmp <- tempfile()
  utils::download.file(data_url(x), tmp)

  e <- new.env()
  load(tmp, envir = e)

  e[[x]]
}

#' Access data stored online.
#'
#' @param x A string giving the name of the dataset to download. The name
#'   of any dataset listed [here](
#'   https://github.com/forestgeo/fgeo.data/tree/master/data) (without the
#'   extension).
#' @inheritParams utils::download.file
#'
#'
#' @return A dataset.
#'
#' @examples
#' # Not running CRAN checks (may take longer than the allowed run time limit)
#' \donttest{
#' # Defaults to read data
#' # The first call is memoised
#' system.time(download_data("unique_id"))
#' # Subsequent calls use the memoised data, so takes no time
#' system.time(download_data("unique_id"))
#'
#' download_data("unique_id")
#'
#' # Can download data to a destination file given by `destfile`
#' tmp <- tempfile()
#' download_data("unique_id", destfile = tmp)
#' load(tmp)
#' unique_id
#' }
#'
#' available_data <- "https://github.com/forestgeo/fgeo.data/tree/master/data"
#' if (interactive()) browseURL(available_data)
#' @family datasets
#' @seealso [utils::download.file()]
#' @export
download_data <- memoise::memoise(download_data_impl)

data_url <- function(x) {
  paste0("https://github.com/forestgeo/fgeo.data/raw/master/data/", x, ".rda")
}
