do_sample_sa1s <- function(
    dat_mrg_sa1_climate
){
  setDT(dat_mrg_sa1_climate)
  
  # Convert pop column to numeric
  dat_mrg_sa1_climate[, pop := as.numeric(pop)]
  
  # Stratified sampling by zone
  num_zones <- 6  # You've listed 6 unique zones
  sa1s_per_zone <- 30 / num_zones  # 5 SA1s from each zone
  
  # Empty list to store selected SA1s
  selected_SA1s <- list()
  
  for(zone in c(2, 4, 6, 10, 14, 18)) {
    sa1s_in_zone <- dat_mrg_sa1_climate[zonegrp_nu == zone]
    
    # Make sure that there are enough SA1s in the zone to select from
    if(nrow(sa1s_in_zone) >= sa1s_per_zone) {
      selected_SA1s[[zone]] <- sa1s_in_zone[sample(.N, sa1s_per_zone)]
    } else {
      selected_SA1s[[zone]] <- sa1s_in_zone
    }
  }
  
  # Combine the selected SA1s
  sampled_SA1s <- rbindlist(selected_SA1s)
  
  # Convert from data.table to data.frame
  sampled_SA1s_df <- as.data.frame(sampled_SA1s)
  
  # Convert data.frame to sf, setting the geometry column
  sampled_SA1s_sf <- st_sf(sampled_SA1s_df, sf_column_name = "geometry")
  
  # Extract the geometries and data separately
  geom_list <- st_geometry(sampled_SA1s_sf)
  data_df <- as.data.frame(sampled_SA1s_sf)
  
  # Filter out empty geometries
  valid_indices <- which(!sapply(geom_list, st_is_empty))
  
  # Reconstruct the sf object with valid geometries only
  valid_geom <- geom_list[valid_indices]
  valid_data <- data_df[valid_indices, ]
  sampled_SA1s_sf_cleaned <- st_sf(valid_data, geometry = valid_geom)
  
  # Attempt to write the cleaned sf object
  st_write(sampled_SA1s_sf_cleaned, file.path(config$dat_derived_dir, "survey_selected_sa1s.shp"))
  
}

