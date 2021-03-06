% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/example_path.R
\name{example_path}
\alias{example_path}
\title{Access data stored in system files.}
\usage{
example_path(path = NULL)
}
\arguments{
\item{path}{Name of file or directory. If \code{NULL}, the example files and
directories will be listed.}
}
\value{
A character string.
}
\description{
\code{example_path()} mostly wraps \code{system.file(..., package = "fgeo.x")}.
}
\examples{
example_path()

dir(example_path("rdata"))

example_path("taxa.csv")

str(read.csv(example_path("taxa.csv")))
}
\seealso{
Other datasets: \code{\link{datasets}},
  \code{\link{download_data}}
}
\concept{datasets}
