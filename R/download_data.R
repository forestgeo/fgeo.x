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
#' \dontrun{
#' available_data <- "https://github.com/forestgeo/fgeo.data/tree/master/data"
#' browseURL(available_data)
#'
#' # May take over 5 seconds (i.e. above the time limit acceptable for CRAN)
#' # Defaults to read data
#' download_data("unique_id")
#'
#' # Can download data to a destination file given by `destfile`
#' tmp <- tempfile()
#' download_data("unique_id", destfile = tmp)
#' load(tmp)
#' unique_id
#' }
#' @family datasets
#' @seealso [utils::download.file()]
#' @export
download_data <- function(x, destfile = NULL) {
  if (!is.null(destfile)) {
    return(utils::download.file(data_url(x), destfile = destfile))
  }

  tmp <- tempfile()
  utils::download.file(data_url(x), tmp)

  e <- new.env()
  load(tmp, envir = e)

  e[[x]]
}

data_url <- function(x) {
  paste0("https://github.com/forestgeo/fgeo.data/raw/master/data/", x, ".rda")
}
