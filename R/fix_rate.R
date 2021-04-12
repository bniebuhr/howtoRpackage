#' Calculate fix rate success for movement data
#'
#' @description This function is designed to calculate and print some basic
#' statistics related to fix rates of animal movement data collected with
#' telemetry devices
#'
#' @param x movement dataset
#'
#' @return Nothing. The statistics are printed in the console.
#'
#' @example examples/fix_rate_example.R
#'
#' @export
fix_rate <- function(x){
  print(paste("Individual:", x$individual.local.identifier[1]))
  dates=range(x$NewDate)
  print(paste("Range:", dates))
  days=as.numeric(round(diff(range(x$NewDate)), digits=0))
  print(paste("Number of monitoring days:", days))
  # sched=as.numeric(round(median(diff.POSIXt(x$NewDate, units = "minutes")), digits=0))
  sched=as.numeric(round(median(abs(diff(sapply(x$NewDate[2:nrow(x)], difftime, time1 = x$NewDate[1], units = "mins", simplify = T))))))
  print(paste("Scheduled fix rate (min):", sched))
  expected=as.numeric(days)*round(1440/(as.numeric(sched)), digits=0)#1440 minutes in a day
  print(paste("Expected number of positions:", expected))
  success <- nrow(x)
  print(paste("Number of recorded positions", success))
  percentfix <- round(success/expected*100)
  print(paste("Fix rate success = ", percentfix,"%", sep=" "))
}
