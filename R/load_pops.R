#' Load population csv from 2016 ABS CENSUS data
#'
#' @param indir The directory where the input file is located (check the config.yaml)
#' @param infile The name of the input file (check infile definition in the target dat_mrg_shp_pop)
#' @param name The name of the resulting data frame (sa1_pop).
#'
#' @return
#' @export
#'
#' @examples
#' #' load_pops(indir = "/path/to/directory", infile = "my_csv_file.csv")

load_pops <- function(
    indir,
    infile,
    name = "dat_sa1_pop"
){
  csv_file <- file.path(
    config$rootdir,
    config$popdir,
    "2016Census_G01_AUS_SA1.csv"
  )
  dat_sa1_pop <- data.table::fread(
        csv_file,
        colClasses = list(
          character = c("SA1_7DIGITCODE_2016",
                        "Tot_P_P")))
      dat_sa1_pop <- dat_sa1_pop[, .(sa1_7dig16 = SA1_7DIGITCODE_2016, pop = Tot_P_P )]
          return(dat_sa1_pop)
}