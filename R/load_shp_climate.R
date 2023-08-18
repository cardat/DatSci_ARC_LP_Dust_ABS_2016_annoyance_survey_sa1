#' Load shapefile from the 2016 ABS CENSUS
#' 
#' @param indir Input directory where the shapefile is stored (check the config.yaml)
#' @param infile Name of the shapefile (check infile definition in the target dat_climate_shp)
#' @param name The name of the resulting data frame (dat_climate_shp)
#'
#' @return A data frame with the loaded shapefile
#'
#' @importFrom sf st_cast st_read st_transform
#' 
#' @examples
#' load_shp(indir = "path/to/dir", infile = "filename.shp", name = "dat_name")
#'
#' @export

load_shp_climate <- function(
    indir = config$rootdir,
    infile = config$shpfile_climate,
    subdir = config$shpdir_climate,
    name = "dat_climate_shp"
){
  shp_file <- file.path(
    config$rootdir, 
    config$shpdir_climate,
    config$shpfile_climate)
  
  dat_climate_shp <- sf::st_read(shp_file)

  # cast the sf object into "MULTIPLOYGON" and transform the spatial ref system used
  dat_climate_shp <- st_cast(dat_climate_shp, "MULTIPOLYGON")
  dat_climate_shp <- st_transform(dat_climate_shp, 4283)
  
  # Lower case 
  names(dat_climate_shp) <- tolower(names(dat_climate_shp))
  
  # Return the resulting data frame
  return(dat_climate_shp)
}
