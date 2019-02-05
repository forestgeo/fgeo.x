pkgname <- "fgeo"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('fgeo')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("fgeo_browse")
### * fgeo_browse

flush(stderr()); flush(stdout())

### Name: fgeo_browse
### Title: Open a web browser on fgeo's website.
### Aliases: fgeo_browse fgeo_browse_reference

### ** Examples

if (interactive()) {
  fgeo_browse()
  fgeo_browse_reference()
}



cleanEx()
nameEx("fgeo_help")
### * fgeo_help

flush(stderr()); flush(stdout())

### Name: fgeo_help
### Title: Get help with fgeo.
### Aliases: fgeo_help

### ** Examples

if (interactive()) {
  fgeo_help()
}

dplyr::as_tibble(fgeo_help()$matches)

if (interactive()) {
  fgeo_help("stem", package = "fgeo.x")
}



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
