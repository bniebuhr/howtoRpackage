## code to prepare `DATASET` dataset goes here

# read data
juveniles <- read.csv("data-raw/subsetGPSlocs.csv")

# create data for use in the Rpackage
usethis::use_data(juveniles, overwrite = TRUE)

# or
dir.create("data/")
save(juveniles, file = "data/juveniles.rda")
