pkgname <- "fgeo.analyze"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('fgeo.analyze')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("abundance")
### * abundance

flush(stderr()); flush(stdout())

### Name: abundance
### Title: Abundance and basal area, optionally by groups.
### Aliases: abundance basal_area

### ** Examples

library(fgeo.tool)

# abundance() -------------------------------------------------------------

abundance(data.frame(1))

# One stem per tree
tree <- tribble(
  ~TreeID, ~StemID, ~DBH,
  "1", "1.1", 11,
  "2", "2.1", 21
)

abundance(tree)

# One tree with multiple stems
stem <- tribble(
  ~TreeID, ~StemID, ~DBH,
  "1", "1.1", 11,
  "1", "1.2", 12
)

abundance(stem)
## Not run: 
##D # Similar but more realistic
##D assert_is_installed("fgeo.x")
##D stem <- fgeo.x::download_data("luquillo_stem5_random")
##D 
##D abundance(stem)
##D 
##D abundance(pick_main_stem(stem))
## End(Not run)

vft <- tribble(
  ~PlotName, ~CensusID, ~TreeID, ~StemID, ~DBH,
  "p", 1, "1", "1.1", 10,
  "q", 2, "1", "1.1", 10
)

# * Warns if it detects multiple values of censusid or plotname
# * Also warns if it detects duplicated values of treeid
abundance(vft)

# If trees have buttressess, the data may have multiple stems per treeid or
# multiple measures per stemid.
vft2 <- tribble(
  ~CensusID, ~TreeID, ~StemID, ~DBH, ~HOM,
  1, "1", "1.1", 88, 130,
  1, "1", "1.1", 10, 160,
  1, "2", "2.1", 20, 130,
  1, "2", "2.2", 30, 130,
)

# You should count only the main stem of each tree
(main_stem <- pick_main_stem(vft2))

abundance(main_stem)

vft3 <- tribble(
  ~CensusID, ~TreeID, ~StemID, ~DBH, ~HOM,
  1, "1", "1.1", 20, 130,
  1, "1", "1.2", 10, 160, # Main stem
  2, "1", "1.1", 12, 130,
  2, "1", "1.2", 22, 130 # Main stem
)

# You can compute by groups
by_census <- group_by(vft3, CensusID)
(main_stems_by_census <- pick_main_stem(by_census))

abundance(main_stems_by_census)

# basal_area() ------------------------------------------------------------

# Data must have a column named dbh (case insensitive)
basal_area(data.frame(dbh = 1))

# * Warns if it detects multiple values of censusid or plotname
# * Also warns if it detects duplicated values of stemid
basal_area(vft)

# First you may pick the main stemid of each stem
(main_stemids <- pick_main_stemid(vft2))

basal_area(main_stemids)

# You can compute by groups
basal_area(by_census)
## Not run: 
##D measurements_is_installed <- requireNamespace("measurements", quietly = TRUE)
##D if (measurements_is_installed) {
##D   library(measurements)
##D 
##D   # Convert units
##D   ba <- basal_area(by_census)
##D   ba$basal_area_he <- conv_unit(
##D     ba$basal_area,
##D     from = "mm2",
##D     to = "hectare"
##D   )
##D 
##D   ba
##D }
## End(Not run)




cleanEx()
nameEx("abundance_byyr")
### * abundance_byyr

flush(stderr()); flush(stdout())

### Name: abundance_byyr
### Title: Create tables of abundance and basal area by year.
### Aliases: abundance_byyr basal_area_byyr

### ** Examples

library(fgeo.tool)

# Example data
vft <- tibble(
  PlotName = c("luq", "luq", "luq", "luq", "luq", "luq", "luq", "luq"),
  CensusID = c(1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L),
  TreeID = c(1L, 1L, 2L, 2L, 1L, 1L, 2L, 2L),
  StemID = c(1.1, 1.2, 2.1, 2.2, 1.1, 1.2, 2.1, 2.2),
  Status = c(
    "alive", "dead", "alive", "alive", "alive", "gone",
    "dead", "dead"
  ),
  DBH = c(10L, NA, 20L, 30L, 20L, NA, NA, NA),
  Genus = c("Gn", "Gn", "Gn", "Gn", "Gn", "Gn", "Gn", "Gn"),
  SpeciesName = c("spp", "spp", "spp", "spp", "spp", "spp", "spp", "spp"),
  ExactDate = c(
    "2001-01-01", "2001-01-01", "2001-01-01", "2001-01-01",
    "2002-01-01", "2002-01-01", "2002-01-01",
    "2002-01-01"
  ),
  PlotCensusNumber = c(1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L),
  Family = c("f", "f", "f", "f", "f", "f", "f", "f"),
  Tag = c(1L, 1L, 2L, 2L, 1L, 1L, 2L, 2L),
  HOM = c(130L, 130L, 130L, 130L, 130L, 130L, 130L, 130L)
)

vft

abundance_byyr(vft, DBH >= 10, DBH < 20)

abundance_byyr(vft, DBH >= 10)

basal <- basal_area_byyr(vft, DBH >= 10)
basal
## Not run: 
##D measurements_is_installed <- requireNamespace("measurements", quietly = TRUE)
##D if (measurements_is_installed) {
##D   # Convert units
##D   years <- c("yr_2001", "yr_2002")
##D   basal_he <- basal %>%
##D     purrr::modify_at(
##D       years,
##D       ~ measurements::conv_unit(.x, from = "mm2", to = "hectare")
##D     )
##D   basal_he
##D 
##D   # Standardize
##D   number_of_hectares <- 50
##D   basal_he %>%
##D     purrr::map_at(years, ~ .x / number_of_hectares)
##D }
## End(Not run)



cleanEx()
nameEx("fgeo_habitat")
### * fgeo_habitat

flush(stderr()); flush(stdout())

### Name: fgeo_habitat
### Title: Create habitat data from measures of topography.
### Aliases: fgeo_habitat

### ** Examples

assert_is_installed("fgeo.x")

# Input a ForestGEO-like elevation list or dataframe
elevation_ls <- fgeo.x::elevation
habitats <- fgeo_habitat(
  elevation_ls,
  gridsize = 20, n = 4
)

str(habitats)

## Not run: 
##D assert_is_installed("fgeo.plot")
##D library(fgeo.plot)
##D 
##D autoplot(habitats)
## End(Not run)

# Habitat data is useful for calculating species-habitat associations
census <- fgeo.x::tree6_3species
as_tibble(
  tt_test(census, habitats)
)



cleanEx()
nameEx("fgeo_topography")
### * fgeo_topography

flush(stderr()); flush(stdout())

### Name: fgeo_topography
### Title: Create topography data: convexity, slope, and mean elevation.
### Aliases: fgeo_topography fgeo_topography.data.frame
###   fgeo_topography.list

### ** Examples

assert_is_installed("fgeo.x")

elev_list <- fgeo.x::elevation
fgeo_topography(elev_list, gridsize = 20)

elev_df <- elev_list$col
fgeo_topography(elev_df, gridsize = 20, xdim = 320, ydim = 500)



cleanEx()
nameEx("recruitment_ctfs")
### * recruitment_ctfs

flush(stderr()); flush(stdout())

### Name: recruitment_ctfs
### Title: Recruitment, mortality, and growth.
### Aliases: recruitment_ctfs mortality_ctfs growth_ctfs

### ** Examples

assert_is_installed("fgeo.x")

census1 <- fgeo.x::tree5
census2 <- fgeo.x::tree6

as_tibble(
  recruitment_ctfs(census1, census2)
)

# Use `interaction(...)` to aggregate by any number of grouping variables
sp_quadrat <- interaction(census1$sp, census1$quadrat)

recruitment <- recruitment_ctfs(
  census1, census2,
  split1 = sp_quadrat,
  quiet = TRUE
)
as_tibble(recruitment)

mortality <- mortality_ctfs(
  census1, census2,
  split1 = sp_quadrat, quiet = TRUE
)
as_tibble(mortality)

growth <- growth_ctfs(census1, census2, split1 = sp_quadrat, quiet = TRUE)
as_tibble(growth)

# Easy way to separate grouping variables
tidyr_is_installed <- requireNamespace("tidyr", quietly = TRUE)
if (tidyr_is_installed) {
  library(tidyr)

  as_tibble(growth) %>%
    separate(groups, into = c("sp", "quadrat"))
}



cleanEx()
nameEx("summary.tt_df")
### * summary.tt_df

flush(stderr()); flush(stdout())

### Name: summary.tt_df
### Title: Summary of 'tt_test()' results.
### Aliases: summary.tt_df summary.tt_lst

### ** Examples

assert_is_installed("fgeo.x")

tt_result <- tt_test(fgeo.x::tree6_3species, fgeo.x::habitat)

summary(tt_result)

# Same
summary(as_tibble(tt_result))

# You may want to add the explanation to the result of `tt_test()`

dplyr::left_join(as_tibble(tt_result), summary(tt_result))

# You may prefer a wide matrix
Reduce(rbind, tt_result)

# You may prefer a wide dataframe
tidyr::spread(summary(tt_result), "habitat", "association")



cleanEx()
nameEx("tt_test")
### * tt_test

flush(stderr()); flush(stdout())

### Name: tt_test
### Title: Torus Translation Test to determine habitat associations of tree
###   species.
### Aliases: tt_test

### ** Examples

library(fgeo.tool)
assert_is_installed("fgeo.x")

# Example data
tree <- fgeo.x::tree6_3species
elevation <- fgeo.x::elevation

# Pick alive trees, of 10 mm or more
census <- filter(tree, status == "A", dbh >= 10)

# Pick sufficiently abundant species
pick <- filter(dplyr::add_count(census, sp), n > 50)

# Use your habitat data or create it from elevation data
habitat <- fgeo_habitat(elevation, gridsize = 20, n = 4)

# Defaults to using all species
as_tibble(
  tt_test(census, habitat)
)

Reduce(rbind, tt_test(census, habitat))

some_species <- c("CASARB", "PREMON")
result <- tt_test(census, habitat, sp = some_species)
summary(result)



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
