#' Merge shape file with population data
#'
#' @param sa1_shp 
#' @param sa1_pop 
#'
#' @return
#' @export
#'
#' @examples
do_mrg_shp_pop <- function(
    dat_sa1_shp, 
    dat_sa1_pop
){
# Join data by SA1 ID
dat_mrg_shp_pop <- merge(
  dat_sa1_shp,
  dat_sa1_pop,
  by = "sa1_7dig16")

# Return merged data
return(dat_mrg_shp_pop)
}