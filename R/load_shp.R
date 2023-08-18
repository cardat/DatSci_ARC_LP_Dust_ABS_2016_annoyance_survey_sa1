#' Load shapefile from the 2016 ABS CENSUS
#' 
#' @param indir Input directory where the shapefile is stored (check the config.yaml)
#' @param infile Name of the shapefile (check infile definition in the target dat_sa1_shp)
#' @param name The name of the resulting data frame (dat_sa1_shp)
#'
#' @return A data frame with the loaded shapefile
#'
#' @importFrom sf st_cast st_read st_transform
#' 
#' @examples
#' load_shp(indir = "path/to/dir", infile = "filename.shp", name = "dat_name")
#'
#' @export

load_shp <- function(
    indir,
    infile,
    name = "dat_sa1_shp"
){
  shp_file <- file.path(
    config$rootdir, 
    config$shpdir,
    config$shpfile)
  
  dat_sa1_shp <- tryCatch(
    {
      dat_sa1_shp <- sf::st_read(shp_file)
      dat_sa1_shp <- dat_sa1_shp[, c("SA1_7DIG16", "GCC_CODE16")]
      
    },
    error = function(e) {
      stop("Error reading shapefile: ", e$message)
    }
  )
  
  # cast the sf object into "MULTIPLOYGON" and transform the spatial ref system used
  dat_sa1_shp <- st_cast(dat_sa1_shp, "MULTIPOLYGON")
  dat_sa1_shp <- st_transform(dat_sa1_shp, 4283)
  
  # Lower case 
  names(dat_sa1_shp) <- tolower(names(dat_sa1_shp))
  
  # Return the resulting data frame
  return(dat_sa1_shp)
}
