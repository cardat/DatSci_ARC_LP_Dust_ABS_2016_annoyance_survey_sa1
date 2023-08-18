library(targets)

lapply(list.files("R", full.names = TRUE), source)

config <- yaml::read_yaml("config.yaml")

tar_option_set(
  packages =
    c("targets",
      "yaml",
      "data.table",
      "sf"
    )
)

list(
  # LOAD&MRG POP&SA1 ####
  #### dat_sa1_shp ####
  tar_target(
    dat_sa1_shp,
    load_shp(
      indir = file.path(
        config$rootdir, 
        config$shpdir),
      infile = config$shpfile
    )
  )
  ,
  #### dat_sa1_pop ####
  tar_target(
    dat_sa1_pop,
    load_pops(
      indir = file.path(
        config$rootdir,
        config$popdir),
      infile = config$popfile
    )
  )
  ,
  ### dat_mrg_shp_pop ####
  tar_target(
    dat_mrg_shp_pop,
    do_mrg_shp_pop(
      dat_sa1_shp,
      dat_sa1_pop
    )
  )
  ,
  # LOAD Clim Zones ####
  ### dat_shp_climate
  tar_target(
    dat_shp_climate,
    load_shp_climate(
      indir = file.path(
        config$rootdir, 
        config$shpdir_climate),
      infile = config$shpfile_climate
    )
  )
  ,
  # MRG Climate & SA1 ####
  tar_target(
    dat_mrg_sa1_climate,
    do_mrg_sa1_climate(
      dat_mrg_shp_pop,
      dat_shp_climate
    )
  )
)