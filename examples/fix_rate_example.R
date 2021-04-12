library(howtoRpackage)
library(sp)
library(plyr)

# read data
data("juveniles")
juveniles

# reference system
Albers.crs <- CRS("+proj=aea +lat_1=29.3 +lat_2=45.3 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")

# prepare data
juveniles_prep <- prepare_data(juveniles)
head(juveniles_prep)

# plot just to visualize
plot(juveniles_prep[[2]])
plot(juveniles_prep[[2]], col = factor(juveniles_prep[[2]]$individual.local.identifier))

library(ggplot2)
ggplot(juveniles_prep[[1]],
       aes(x, y, color = individual.local.identifier)) +
  geom_point()

# calculate fix rate success
fix_deer <- plyr::ddply(juveniles_prep[[1]], .(individual.local.identifier), fix_rate)
