#' prepare data for analysis
#'
#' @export
prepare_data <- function(dat) {

  # date-time as posixct
  dat$NewDate <- as.POSIXct(dat$NewDate, format="%Y-%m-%d %H:%M:%S", tz="EST")

  # season-year variable
  dat$SeasonYear <- NULL
  dat$SeasonYear[dat$NewDate > "2018-01-01 00:00:00" &
                   dat$NewDate < "2018-08-01 00:00:00"] <- "Spring18"
  dat$SeasonYear[dat$NewDate > "2019-01-01 00:00:00" &
                   dat$NewDate < "2019-08-01 00:00:00"] <- "Spring19"
  dat$SeasonYear[dat$NewDate > "2020-01-01 00:00:00" &
                   dat$NewDate < "2020-08-11 00:00:00"] <- "Spring20"
  dat$SeasonYear[dat$NewDate > "2018-07-31 23:59:00" &
                   dat$NewDate < "2018-12-31 23:59:00"] <- "Fall18"
  dat$SeasonYear[dat$NewDate > "2019-07-31 23:59:00" &
                   dat$NewDate < "2019-12-31 23:59:00"] <- "Fall19"

  # burst for each individual and season-year
  dat$SeasonYearBurst <- c(paste(dat$individual.local.identifier,dat$SeasonYear,sep="_"))
  dat$SeasonYearBurst <- as.factor(dat$SeasonYearBurst)

  # transform into spdf
  juv18to20 <-data.frame(x = dat$x, y = dat$y)

  juv18to20.spdf <- SpatialPointsDataFrame(coords= juv18to20, data = juveniles, proj4string = Albers.crs)

  list(dat, juv18to20.spdf)
  # save
  # writeOGR(juv18to20.spdf, dsn = ".", layer="PA_juveniles_all", driver = "ESRI Shapefile")
  # write.csv(juveniles,"juvenileGPSlocs.csv")
}
