pkgname <- "fgeo.tool"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('fgeo.tool')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("add_status_tree")
### * add_status_tree

flush(stderr()); flush(stdout())

### Name: add_status_tree
### Title: Add column 'status_tree' based on the status of all stems of
###   each tree.
### Aliases: add_status_tree

### ** Examples

stem <- tribble(
  ~CensusID, ~treeID, ~stemID, ~status,
          1,       1,       1,     "A",
          1,       1,       2,     "D",
          
          1,       2,       3,     "D",
          1,       2,       4,     "D",
          
          
          
          2,       1,       1,     "A",
          2,       1,       2,     "G",
          
          2,       2,       3,     "D",
          2,       2,       4,     "G"
)

add_status_tree(stem)




cleanEx()
nameEx("add_subquad")
### * add_subquad

flush(stderr()); flush(stdout())

### Name: add_subquad
### Title: Add column 'subquadrat' based on 'QX' and 'QY' coordinates.
### Aliases: add_subquad

### ** Examples

vft <- tribble(
   ~QX,  ~QY,
  17.9,    0,
   4.1,   15,
   6.1, 17.3,
   3.8,  5.9,
   4.5, 12.4,
   4.9,  9.3,
   9.8,  3.2,
  18.6,  1.1,
  17.3,  4.1,
   1.5, 16.3
)

add_subquad(vft, 20, 20, 5, 5)

add_subquad(vft, 20, 20, 5, 5, subquad_offset = -1)




cleanEx()
nameEx("add_var")
### * add_var

flush(stderr()); flush(stdout())

### Name: add_var
### Title: Add columns 'lx/ly', 'QX/QY', 'index', 'col/row', 'hectindex',
###   'quad', 'gx/gy'.
### Aliases: add_var add_lxly add_qxqy add_index add_col_row add_hectindex
###   add_quad add_gxgy

### ** Examples

x <- tribble(
    ~gx,    ~gy,
      0,      0,
     50,     25,
  999.9, 499.95,
   1000,    500
)

# `gridsize` has a common default; `plotdim` is guessed from the data
add_lxly(x)

gridsize <- 20
plotdim <- c(1000, 500)

add_qxqy(x, gridsize, plotdim)

add_index(x, gridsize, plotdim)

add_hectindex(x, gridsize, plotdim)

add_quad(x, gridsize, plotdim)

add_quad(x, gridsize, plotdim, start = 0)

# `width` gives the nuber of digits to pad the label of plot-rows and
# plot-columns, e.g. 3 pads plot-rows with three zeros and plot-columns with
# an extra trhree zeros, resulting in a total of 6 zeros.
add_quad(x, gridsize, plotdim, start = 0, width = 3)

add_col_row(x, gridsize, plotdim)


# From `quadrat` or `QuadratName` --------------------------------------
x <- tribble(
  ~QuadratName,
        "0001",
        "0011",
        "0101",
        "1001"
)

# Output `gx` and `gy` ---------------

add_gxgy(x)
 
assert_is_installed("fgeo.x")
# Warning: The data may already have `gx` and `gx` columns
gxgy <- add_gxgy(fgeo.x::tree5)
select(gxgy, matches("gx|gy"))

# Output `col` and `row` -------------

# Create columns `col` and `row` from `QuadratName` with `tidyr::separate()`
# The argument `sep` lets you separate `QuadratName` at any positon
## Not run: 
##D tidyr_is_installed <- requireNamespace("tidyr", quietly = TRUE)
##D stringr_is_installed <- requireNamespace("stringr", quietly = TRUE)
##D 
##D if (tidyr_is_installed && stringr_is_installed) {
##D   library(tidyr)
##D   library(stringr)
##D 
##D   vft <- tibble(QuadratName = c("0001", "0011"))
##D   vft
##D 
##D   separate(
##D     vft,
##D     QuadratName,
##D     into = c("col", "row"),
##D     sep = 2
##D   )
##D 
##D   census <- select(fgeo.x::tree5, quadrat)
##D   census
##D 
##D   census$quadrat <- str_pad(census$quadrat, width = 4, pad = 0)
##D 
##D   separate(
##D     census,
##D     quadrat,
##D     into = c("col", "row"),
##D     sep = 2,
##D     remove = FALSE
##D   )
##D }
## End(Not run)




cleanEx()
nameEx("assert_is_installed")
### * assert_is_installed

flush(stderr()); flush(stdout())

### Name: assert_is_installed
### Title: Assert a package is installed.
### Aliases: assert_is_installed
### Keywords: internal

### ** Examples

assert_is_installed("base")
## Not run: 
##D try(assert_is_installed("bad"))
## End(Not run)



cleanEx()
nameEx("check_crucial_names")
### * check_crucial_names

flush(stderr()); flush(stdout())

### Name: check_crucial_names
### Title: Check if an object contains specific names.
### Aliases: check_crucial_names
### Keywords: internal

### ** Examples

v <- c(x = 1)
check_crucial_names(v, "x")

dfm <- data.frame(x = 1)
check_crucial_names(dfm, "x")



cleanEx()
nameEx("drop_if_na")
### * drop_if_na

flush(stderr()); flush(stdout())

### Name: drop_if_na
### Title: Drop if missing values.
### Aliases: drop_if_na
### Keywords: internal

### ** Examples

dfm <- data.frame(a = 1, b = NA)
drop_if_na(dfm, "b")
drop_if_na(dfm, "a")



cleanEx()
nameEx("extract_from_habitat")
### * extract_from_habitat

flush(stderr()); flush(stdout())

### Name: extract_from_habitat
### Title: Extract plot dimensions from habitat data.
### Aliases: extract_from_habitat extract_gridsize extract_plotdim
### Keywords: internal

### ** Examples

assert_is_installed("fgeo.x")
habitat <- fgeo.x::habitat
extract_plotdim(habitat)
extract_gridsize(habitat)



cleanEx()
nameEx("extract_insensitive")
### * extract_insensitive

flush(stderr()); flush(stdout())

### Name: extract_insensitive
### Title: Detect and extract matching strings - ignoring case.
### Aliases: extract_insensitive detect_insensitive
### Keywords: internal

### ** Examples

x <- c("stemid", "n")
y <- c("StemID", "treeID")
detect_insensitive(x, y)
extract_insensitive(x, y)

vft <- data.frame(TreeID = 1, Status = 1)
extract_insensitive(tolower(names(vft)), names(vft))
extract_insensitive(names(vft), tolower(names(vft)))



cleanEx()
nameEx("fgeo_elevation")
### * fgeo_elevation

flush(stderr()); flush(stdout())

### Name: fgeo_elevation
### Title: Create elevation data.
### Aliases: fgeo_elevation

### ** Examples

assert_is_installed("fgeo.x")

# Input: Elevation dataframe
elevation_df <- fgeo.x::elevation$col
fgeo_elevation(elevation_df)

class(elevation_df)
class(fgeo_elevation(elevation_df))

names(elevation_df)
names(fgeo_elevation(elevation_df))

# Input: Elevation list
elevation_ls <- fgeo.x::elevation
fgeo_elevation(elevation_ls)

class(elevation_ls)
class(fgeo_elevation(elevation_ls))

names(elevation_ls)
names(fgeo_elevation(elevation_ls))



cleanEx()
nameEx("flag_if")
### * flag_if

flush(stderr()); flush(stdout())

### Name: flag_if
### Title: Flag if a vector or dataframe-column meets a condition.
### Aliases: flag_if flag_if.default flag_if.data.frame
### Keywords: internal

### ** Examples

# WITH VECTORS
dupl <- c(1, 1)
flag_if(dupl, is_duplicated)
# Silent
flag_if(dupl, is_multiple)

mult <- c(1, 2)
flag_if(mult, is_multiple, message, "Custom")
# Silent
flag_if(mult, is_duplicated)

# Both silent
flag_if(c(1, NA), is_multiple)
flag_if(c(1, NA), is_duplicated)

# WITH DATAFRAMES
.df <- data.frame(a = 1:3, b = 1, stringsAsFactors = FALSE)
flag_if(.df, "b", is_multiple)
flag_if(.df, "a", is_multiple)
flag_if(.df, "a", is_multiple, message, "Custom")



cleanEx()
nameEx("flag_if_group")
### * flag_if_group

flush(stderr()); flush(stdout())

### Name: flag_if_group
### Title: Detect and flag based on a predicate applied to a variable by
###   groups.
### Aliases: flag_if_group detect_if_group
### Keywords: internal

### ** Examples

tree <- tibble(CensusID = c(1, 2), treeID = c(1, 2))
detect_if_group(tree, "treeID", is_multiple)
flag_if_group(tree, "treeID", is_multiple)

by_censusid <- group_by(tree, CensusID)
detect_if_group(by_censusid, "treeID", is_multiple)
flag_if_group(by_censusid, "treeID", is_multiple)



cleanEx()
nameEx("from_var_to_var")
### * from_var_to_var

flush(stderr()); flush(stdout())

### Name: from_var_to_var
### Title: Functions to get variables from other variables.
### Aliases: from_var_to_var rowcol_to_index index_to_rowcol gxgy_to_index
###   gxgy_to_lxly gxgy_to_qxqy gxgy_to_rowcol gxgy_to_hectindex
###   index_to_gxgy
### Keywords: internal

### ** Examples

gxgy_to_index(c(0, 400, 990), c(0, 200, 490), gridsize = 20)

gridsize <- 20
plotdim <- c(1000, 500)

x <- gxgy_to_hectindex(1:3, 1:3, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

x <- gxgy_to_index(1:3, 1:3, gridsize, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

x <- gxgy_to_lxly(1:3, 1:3, gridsize, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

x <- gxgy_to_rowcol(1:3, 1:3, gridsize, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

x <- index_to_rowcol(1:3, gridsize, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

x <- rowcol_to_index(1:3, 1:3, gridsize, plotdim)
x
typeof(x)
is.data.frame(x)
is.vector(x)

index_to_gxgy(1:3, gridsize, plotdim)



cleanEx()
nameEx("guess_plotdim")
### * guess_plotdim

flush(stderr()); flush(stdout())

### Name: guess_plotdim
### Title: Guess plot dimensions.
### Aliases: guess_plotdim
### Keywords: internal

### ** Examples

x <- data.frame(
  gx = c(0, 300, 979),
  gy = c(0, 300, 481)
)
guess_plotdim(x)



cleanEx()
nameEx("is_multiple")
### * is_multiple

flush(stderr()); flush(stdout())

### Name: is_multiple
### Title: Predicates to detect and flag duplicated and multiple values of
###   a variable.
### Aliases: is_multiple is_duplicated
### Keywords: internal

### ** Examples

is_multiple(c(1, 2))
is_multiple(c(1, 1))
is_multiple(c(1, NA))

is_duplicated(c(1, 2))
is_duplicated(c(1, 1))
is_duplicated(c(1, NA))



cleanEx()
nameEx("nms_try_rename")
### * nms_try_rename

flush(stderr()); flush(stdout())

### Name: nms_try_rename
### Title: Try to rename an object.
### Aliases: nms_try_rename
### Keywords: internal

### ** Examples

nms_try_rename(c(a = 1), "A", "a")
nms_try_rename(data.frame(a = 1), "A", "a")

# Passes
nms_try_rename(c(a = 1, 1), "A", "a")
## Not run: 
##D # Errs
##D # nms_try_rename(1, "A", "A")
## End(Not run)




cleanEx()
nameEx("pick_drop")
### * pick_drop

flush(stderr()); flush(stdout())

### Name: pick_drop
### Title: Pick and drop rows from _ViewFullTable_, _tree_, and _stem_
###   tables.
### Aliases: pick_drop pick_dbh_min pick_dbh_max pick_dbh_under
###   pick_dbh_over pick_status drop_status

### ** Examples

census <- tribble(
  ~dbh, ~status,
     0,     "A",
    50,     "A",
   100,     "A",
   150,     "A",
    NA,     "M",
    NA,     "D",
    NA,      NA
  )

# <=
pick_dbh_max(census, 100)
pick_dbh_max(census, 100, na.rm = TRUE)

# >=
pick_dbh_min(census, 100)
pick_dbh_min(census, 100, na.rm = TRUE)

# <
pick_dbh_under(census, 100)
pick_dbh_under(census, 100, na.rm = TRUE)

# >
pick_dbh_over(census, 100)
pick_dbh_over(census, 100, na.rm = TRUE)
# Same, but `subset()` does not let you keep NAs.
subset(census, dbh > 100)

# ==
pick_status(census, "A")
pick_status(census, "A", na.rm = TRUE)

# !=
drop_status(census, "D")
drop_status(census, "D", na.rm = TRUE)

# Compose
pick_dbh_over(
  drop_status(census, "D", na.rm = TRUE), 
  100
)

# More readable as a pipiline
census %>%
  drop_status("D", na.rm = TRUE) %>%
  pick_dbh_over(100)
 
# Also works with ViewFullTables
vft <- tribble(
  ~DBH,   ~Status,
     0,   "alive",
    50,   "alive",
   100,   "alive",
   150,   "alive",
    NA, "missing",
    NA,    "dead",
    NA,        NA
)

pick_dbh_max(vft, 100)

pick_status(vft, "alive",  na.rm = TRUE)




cleanEx()
nameEx("pick_main_stem")
### * pick_main_stem

flush(stderr()); flush(stdout())

### Name: pick_main_stem
### Title: Pick the main stem or main stemid(s) of each tree in each
###   census.
### Aliases: pick_main_stem pick_main_stemid

### ** Examples

# One `treeID` with multiple stems. 
# `stemID == 1.1` has two measurements (due to buttresses).
# `stemID == 1.2` has a single measurement.
census <- tribble(
    ~sp, ~treeID, ~stemID,  ~hom, ~dbh, ~CensusID,
  "sp1",     "1",   "1.1",   140,   40,         1,  # main stemID (max `hom`)
  "sp1",     "1",   "1.1",   130,   60,         1,  
  "sp1",     "1",   "1.2",   130,   55,         1   # main stemID (only one)
)

# Picks a unique row per unique `treeID`
pick_main_stem(census)

# Picks a unique row per unique `stemID`
pick_main_stemid(census)




cleanEx()
nameEx("read_vft")
### * read_vft

flush(stderr()); flush(stdout())

### Name: read_vft
### Title: Import _ViewFullTable_ or _ViewTaxonomy_ data from a .tsv or
###   .csv file.
### Aliases: read_vft read_taxa

### ** Examples

assert_is_installed("fgeo.x")
library(fgeo.x)

example_path()

file_vft <- example_path("view/vft_4quad.csv")
read_vft(file_vft)

file_taxa <- example_path("view/taxa.csv")
read_taxa(file_taxa)



cleanEx()
nameEx("recode_subquad")
### * recode_subquad

flush(stderr()); flush(stdout())

### Name: recode_subquad
### Title: Recode subquadrat.
### Aliases: recode_subquad
### Keywords: internal

### ** Examples

first_subquad_11 <- tibble(subquadrat = c("11", "12", "22"))
first_subquad_11

first_subquad_01 <- recode_subquad(first_subquad_11, offset = -1)
first_subquad_01

first_subquad_11 <- recode_subquad(first_subquad_01, offset = 1)
first_subquad_11



cleanEx()
nameEx("rename_matches")
### * rename_matches

flush(stderr()); flush(stdout())

### Name: rename_matches
### Title: Rename an object based on case-insensitive match of the names of
###   a reference.
### Aliases: rename_matches
### Keywords: internal

### ** Examples

ref <- data.frame(COL1 = 1, COL2 = 1)
x <- data.frame(col1 = 5, col2 = 1, n = 5)
rename_matches(x, ref)



cleanEx()
nameEx("sanitize_vft")
### * sanitize_vft

flush(stderr()); flush(stdout())

### Name: sanitize_vft
### Title: Fix common problems in _ViewFullTable_ and _ViewTaxonomy_ data.
### Aliases: sanitize_vft sanitize_taxa

### ** Examples

assert_is_installed("fgeo.x")

vft <- fgeo.x::vft_4quad

# Introduce problems to show how to fix them
# Bad column types
vft[] <- lapply(vft, as.character)
# Bad representation of missing values
vft$PlotName <- "NULL"

# "NULL" should be replaced by `NA` and `DBH` should be numeric
str(vft[c("PlotName", "DBH")])

# Fix
vft_sane <- sanitize_vft(vft)
str(vft_sane[c("PlotName", "DBH")])

taxa <- read.csv(fgeo.x::example_path("taxa.csv"))
# E.g. inserting bad column types
taxa[] <- lapply(taxa, as.character)
# E.g. inserting bad representation of missing values
taxa$SubspeciesID <- "NULL"

# "NULL" should be replaced by `NA` and `ViewID` should be integer
str(taxa[c("SubspeciesID", "ViewID")])

# Fix
taxa_sane <- sanitize_taxa(taxa)
str(taxa_sane[c("SubspeciesID", "ViewID")])



cleanEx()
nameEx("type_ensure")
### * type_ensure

flush(stderr()); flush(stdout())

### Name: type_ensure
### Title: Ensure the specific columns of a dataframe have a particular
###   type.
### Aliases: type_ensure
### Keywords: internal

### ** Examples

dfm <- tibble(
  w = c(NA, 1, 2),
  x = 1:3,
  y = as.character(1:3),
  z = letters[1:3]
)
dfm
type_ensure(dfm, c("w", "x", "y"), "numeric")
type_ensure(dfm, c("w", "x", "y", "z"), "character")



cleanEx()
nameEx("type_vft")
### * type_vft

flush(stderr()); flush(stdout())

### Name: type_vft
### Title: Help to read ForestGEO data safely, with consistent columns
###   type.
### Aliases: type_vft type_taxa
### Keywords: internal

### ** Examples

assert_is_installed("fgeo.x")
library(fgeo.x)
library(readr)

str(type_vft())

read_csv(example_path("view/vft_4quad.csv"), col_types = type_vft())

str(type_taxa())

read_csv(example_path("view/taxa.csv"), col_types = type_taxa())



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
