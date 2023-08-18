do_mrg_sa1_climate <- function(
    dat_mrg_shp_pop,
    dat_shp_climate
){
# Ensure both data frames are of class "sf"
dat_shp_climate <- sf::st_as_sf(dat_shp_climate)
dat_mrg_shp_pop <- sf::st_as_sf(dat_mrg_shp_pop)

# Fix invalid geometries
dat_shp_climate <- sf::st_make_valid(dat_shp_climate)
dat_mrg_shp_pop <- sf::st_make_valid(dat_mrg_shp_pop)

# Perform the spatial join
dat_mrg_sa1_climate <- sf::st_join(dat_mrg_shp_pop, dat_shp_climate, join = st_within)

return(dat_mrg_sa1_climate)
}