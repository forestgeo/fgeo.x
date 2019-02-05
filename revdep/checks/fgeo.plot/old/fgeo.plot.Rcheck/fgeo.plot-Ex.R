pkgname <- "fgeo.plot"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('fgeo.plot')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("autoplot.fgeo_habitat")
### * autoplot.fgeo_habitat

flush(stderr()); flush(stdout())

### Name: autoplot.fgeo_habitat
### Title: Plot habitats.
### Aliases: autoplot.fgeo_habitat

### ** Examples

## Not run: 
##D assert_is_installed("fgeo.x")
##D assert_is_installed("fgeo.analyze")
##D library(fgeo.analyze)
##D 
##D habitats <- fgeo_habitat(fgeo.x::elevation, gridsize = 20, n = 4)
##D autoplot(habitats)
## End(Not run)



cleanEx()
nameEx("autoplot.sp_elev")
### * autoplot.sp_elev

flush(stderr()); flush(stdout())

### Name: autoplot.sp_elev
### Title: Plot species distribution and/or topography.
### Aliases: autoplot.sp_elev autoplot.sp autoplot.elev

### ** Examples

assert_is_installed("fgeo.x")

# Species ---------------------------------------------------------------

# Small dataset with a few species for quick examples
census <- fgeo.x::tree5 %>%
  subset(sp %in% c("PREMON", "CASARB"))

autoplot(sp(census))

## Not run: 
##D # Customize
##D autoplot(sp(census), point_size = 1)
## End(Not run)

# Elevation -------------------------------------------------------------

elevation <- fgeo.x::elevation
autoplot(elev(elevation))  

## Not run: 
##D # Same as `autoplot(elev(elevation))`
##D autoplot(elev(elevation$col))
##D 
##D # Customize
##D autoplot(elev(elevation), contour_size = 1)
## End(Not run)

# Species and elevation -------------------------------------------------

autoplot(sp_elev(census, elevation), facet = FALSE, point_size = 1)



cleanEx()
nameEx("autoplot_by_species.sp_elev")
### * autoplot_by_species.sp_elev

flush(stderr()); flush(stdout())

### Name: autoplot_by_species.sp_elev
### Title: List plots of species distribution and topography (good for pdf
###   output).
### Aliases: autoplot_by_species.sp_elev autoplot_by_species.sp

### ** Examples

assert_is_installed("fgeo.x")

# Species ---------------------------------------------------------------
# Small dataset with a few species for quick examples
census <- fgeo.x::tree6_3species

# Showing only two species for speed
autoplot_by_species(sp(census))[1:2]
## Not run: 
##D # Print all plots in the list
##D pdf("map.pdf", paper = "letter", height = 10.5, width = 8)
##D autoplot_by_species(sp(census))
##D dev.off()
## End(Not run)

# Species and elevation (optional) ---------------------------------------

# Species and elevation
elevation <- fgeo.x::elevation
autoplot_by_species(sp_elev(census, elevation))



cleanEx()
nameEx("elev")
### * elev

flush(stderr()); flush(stdout())

### Name: elev
### Title: Allow autoplotting the column 'elev'.
### Aliases: elev

### ** Examples

assert_is_installed("fgeo.x")

inherits(elev(fgeo.x::elevation), "elev")
inherits(elev(fgeo.x::elevation$col), "elev")



cleanEx()
nameEx("header_dbh_bubbles")
### * header_dbh_bubbles

flush(stderr()); flush(stdout())

### Name: header_dbh_bubbles
### Title: Pre-made headers.
### Aliases: header_dbh_bubbles
### Keywords: internal

### ** Examples

cat(header_dbh_bubbles())



cleanEx()
nameEx("header_tag_status")
### * header_tag_status

flush(stderr()); flush(stdout())

### Name: header_tag_status
### Title: Pre-made headers.
### Aliases: header_tag_status
### Keywords: internal

### ** Examples

cat(header_tag_status())



cleanEx()
nameEx("plot_dbh_bubbles_by_quadrat")
### * plot_dbh_bubbles_by_quadrat

flush(stderr()); flush(stdout())

### Name: plot_dbh_bubbles_by_quadrat
### Title: List dbh bubble-plots by quadrat (good for .pdf output).
### Aliases: plot_dbh_bubbles_by_quadrat

### ** Examples

assert_is_installed("fgeo.x")

# Create a small VieFullTable
first_n <- function(x, n) x %in% sort(unique(x))[1:n]
small_vft <- fgeo.x::vft_4quad %>%
  dplyr::filter(first_n(CensusID, 1) & first_n(QuadratID, 2)) %>%
  dplyr::sample_n(50)

plot_dbh_bubbles_by_quadrat(small_vft)

# Printing all plots to .pdf, with parameters optimized for size letter
## Not run: 
##D pdf("map.pdf", paper = "letter", height = 10.5, width = 8)
##D plot_dbh_bubbles_by_quadrat(small_vft)
##D dev.off()
##D 
##D # Be careful if subsetting by DBH: You may unintentionally remove dead trees.
##D # You should explicietly inlcude missing `DBH` values with `is.na(DBH)`
##D include_missing_dbh <- subset(small_vft, DBH > 20 | is.na(DBH))
##D plot_dbh_bubbles_by_quadrat(include_missing_dbh)
## End(Not run)

# Customizing the maps ----------------------------------------------------
# A custom title and header
myheader <- paste(
  " ",
  "Head column 1                     Head column 2                          ",
  " ",
  " ........................................................................",
  " ........................................................................",
  sep = "\n"
)

plot_dbh_bubbles_by_quadrat(
  small_vft,
  title_quad = "My Site, 2018. Quad:",
  header = myheader
)

## Not run: 
##D # Tweak the theme with ggplot
##D library(ggplot2)
##D 
##D plot_dbh_bubbles_by_quadrat(
##D   small_vft,
##D   title_quad = "My Site, 2018. Quad:",
##D   header = header_dbh_bubbles("spanish"),
##D   tag_size = 3,
##D   theme = theme_dbh_bubbles(
##D     axis.text = NULL, # NULL shows axis.text; element_blank() doesn't.
##D     plot.title = element_text(size = 15),
##D     plot.subtitle = element_text(size = 5),
##D     panel.background = element_rect(fill = "grey")
##D   )
##D )
## End(Not run)



cleanEx()
nameEx("plot_tag_status_by_subquadrat")
### * plot_tag_status_by_subquadrat

flush(stderr()); flush(stdout())

### Name: plot_tag_status_by_subquadrat
### Title: List plots of tree-tag status by subquadrat (good for .pdf
###   output).
### Aliases: plot_tag_status_by_subquadrat

### ** Examples

assert_is_installed("fgeo.x")

# Create a small VieFullTable
first <- function(x) x %in% sort(unique(x))[1]
small_vft <- subset(fgeo.x::vft_4quad, first(CensusID) & first(QuadratID))

p <- plot_tag_status_by_subquadrat(small_vft)
# Showing only two sub-quadtrats
p[1:2]

# Print all plots to .pdf, with parameters optimized for size letter
## Not run: 
##D pdf("map.pdf", paper = "letter", height = 10.5, width = 8)
##D plot_tag_status_by_subquadrat(small_vft)
##D dev.off()
##D 
##D # Be careful if filtering by DBH: You may unintentionally remove dead trees.
##D # * If you filter by `DBH`, you loose the dead trees becaue their `DBH = NA`
##D # * You should explicietly inlcude missing DBH values with `is.na(DBH)`
##D include_missing_dbh <- subset(small_vft, DBH > 20 | is.na(DBH))
##D p <- plot_tag_status_by_subquadrat(include_missing_dbh)
##D # Showing only the first plot to keep the output short
##D p[[1]]
## End(Not run)

# Customizing the maps ----------------------------------------------------
# Common tweaks
p <- plot_tag_status_by_subquadrat(
  small_vft,
  title_quad = "BCI 2012. Quadrat: ",
  bl = "bottom-left", br = "bottom-right", tr = "top-right", tl = "top-left",
  header = "Line 1: _________\nLine 2:\nLine 3:.....................",
  subquad_offset = -1,
  point_size = 3, point_shape = c(17, 6),
  tag_size = 2,
  move_edge = 0.5
)
p[[1]]

## Not run: 
##D p <- plot_tag_status_by_subquadrat(
##D   small_vft,
##D   show_page = FALSE,
##D   show_subquad = FALSE
##D )
##D p[[1]]
##D 
##D # Themes
##D library(ggplot2)
##D 
##D p <- plot_tag_status_by_subquadrat(small_vft, theme = theme_gray())
##D p[[1]]
##D 
##D # Tweaking the default theme of plot_tag_status_by_subquadrat()
##D # For many more options see ?ggplot2::theme
##D small_tweak <- theme_tag_status(legend.position = "bottom")
##D p <- plot_tag_status_by_subquadrat(small_vft, theme = small_tweak)
##D p[[1]]
## End(Not run)



cleanEx()
nameEx("sp")
### * sp

flush(stderr()); flush(stdout())

### Name: sp
### Title: Allow autoplotting the column 'sp'.
### Aliases: sp

### ** Examples

assert_is_installed("fgeo.x")

inherits(sp(fgeo.x::stem5), "sp")



cleanEx()
nameEx("sp_elev")
### * sp_elev

flush(stderr()); flush(stdout())

### Name: sp_elev
### Title: Allow autoplotting the columns 'sp' and 'elev'.
### Aliases: sp_elev

### ** Examples

assert_is_installed("fgeo.x")

species_elevation <- sp_elev(fgeo.x::stem5, fgeo.x::elevation)
inherits(species_elevation, "sp_elev")



cleanEx()
nameEx("suffix_match")
### * suffix_match

flush(stderr()); flush(stdout())

### Name: suffix_match
### Title: Suffix a strings where a vector exactly matches one specific
###   string.
### Aliases: suffix_match
### Keywords: internal

### ** Examples

suffix_match(
  string = c("one", "banana"),
  to_match = c("number", "fruit"),
  .match = "number",
  suffix = "_num"
)

suffix_match(
  string = c("tag1", "tag2"),
  to_match = c("dead", "not-dead"),
  .match = "dead",
  suffix = ".d"
)

vft <- data.frame(
  Tag = c("01", "02"),
  Status = c("dead", "alive"),
  stringsAsFactors = FALSE
)
transform(vft, tagged = suffix_match(Tag, Status, "dead", ".d"))



cleanEx()
nameEx("theme_dbh_bubbles")
### * theme_dbh_bubbles

flush(stderr()); flush(stdout())

### Name: theme_dbh_bubbles
### Title: Theme for 'theme_dbh_bubbles()'.
### Aliases: theme_dbh_bubbles
### Keywords: internal

### ** Examples

class(theme_dbh_bubbles())



cleanEx()
nameEx("theme_default")
### * theme_default

flush(stderr()); flush(stdout())

### Name: theme_default
### Title: Default plot theme.
### Aliases: theme_default
### Keywords: internal

### ** Examples

class(theme_default(ggplot2::ggplot(iris)))



cleanEx()
nameEx("theme_tag_status")
### * theme_tag_status

flush(stderr()); flush(stdout())

### Name: theme_tag_status
### Title: Theme for 'plot_base_census()'.
### Aliases: theme_tag_status
### Keywords: internal

### ** Examples

class(theme_tag_status())



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
