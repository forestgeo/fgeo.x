# Ensures data remains the same accross runs
set.seed(123)

library(dplyr)
library(usethis)
library(purrr)
library(tibble)

pick_n <- function(x, y, n) {
  list(x, y) %>%
    fgeo.tool::as_censuses() %>%
    fgeo.tool::pick(rowid %in% sample(rowid, n))
}



tree_ls <- pick_n(
  fgeo.data::luquillo_tree5_random,
  fgeo.data::luquillo_tree6_random,
  30
) %>%
  map(as.tibble)

tree5 <- tree_ls[[1]]
tree6 <- tree_ls[[2]]
use_data(tree5, tree6, overwrite = TRUE)



stem_ls <- pick_n(
  fgeo.data::luquillo_stem5_random,
  fgeo.data::luquillo_stem6_random,
  30
) %>%
  map(as.tibble)

stem5 <- stem_ls[[1]]
stem6 <- stem_ls[[2]]
use_data(stem5, stem6, overwrite = TRUE)



elevation <- fgeo.data::luquillo_elevation
elevation$col <- as.tibble(elevation$col)
use_data(elevation, overwrite = TRUE)



vft_4quad <- fgeo.data::luquillo_vft_4quad %>%
  dplyr::sample_n(500) %>%
  as.tibble()
use_data(vft_4quad, overwrite = TRUE)



taxa <- as.tibble(fgeo.data::luquillo_taxa)
use_data(taxa, overwrite = TRUE)



habitat <- as.tibble(fgeo.data::luquillo_habitat)
use_data(habitat, overwrite = TRUE)



cns <- fgeo.data::luquillo_tree6_random
top3_sp <- cns %>%
  count(sp) %>%
  arrange(desc(n)) %>%
  top_n(3) %>%
  pull(sp)
tree6_3species <- dplyr::filter(cns, sp %in% top3_sp)
use_data(tree6_3species, overwrite = TRUE)
