library(oce)
##cl <- read.oce("~/Downloads/map.osm")
##save(cl, file="cl.rda")
load("cl.rda")
data(coastlineHalifax)
plot(coastlineHalifax, clon=-63.56, clat=44.640, span=4)
lines(cl[['longitude']], cl[['latitude']], col='red')


