library(oce)
source('proj.R')
cameraLat <- 44.634719170
cameraLon <- -63.571794927
data(coastlineHalifax)
## camera at 44.634719170 -63.571794927
imageHeight <- 1680
imageWidth <- 2240
gcp <- read.table('gcp-1020248.dat', header=TRUE)
gcp$i <- gcp$xpix
gcp$j <- imageHeight - gcp$ypix

par(mfrow=c(2,2))

## lat-lon map
plot(coastlineHalifax, clatitude=44.640, clongitude=-63.56, span=4)
points(gcp$lon, gcp$lat)
points(cameraLon, cameraLat, pch='x')
##text(gcp$lon, gcp$lat, 1:length(gcp$lon), pos=1)

## xy map
xy <- geodXy(gcp$lat, gcp$lon, cameraLat, cameraLon)
plot(xy, asp=1, xlab="map x [m]", ylab="map y [m]", xlim=c(0,2500))
points(0, 0, pch='x')

misfit <- function(p)
{
    p <- proj(gcp$i, gcp$j, p[["elevation"]], p[["altitude"]], p[["azimuth"]], p[["fov"]])
    sqrt(mean((xy$x - p$x)^2 + (xy$y - p$y)^2, na.rm=TRUE))
}
o <- optim(c(elevation=30, altitude=-20, azimuth=-30, fov=40), misfit)
elevation <- o$par[1]
altitude <- o$par[2]
azimuth <- (o$par[3])
fov <- o$par[4]

## show prediction
pred <- proj(gcp$i, gcp$j, elevation, altitude, azimuth, fov)
predLat <- cameraLat + pred$y / 111e3
predLon <- cameraLon + pred$x / 111e3 / cos(cameraLat * pi / 180)
plot(coastlineHalifax, clatitude=44.640, clongitude=-63.56, span=4)
points(predLon, predLat)
points(cameraLon, cameraLat, pch='x')

plot(pred$x, pred$y, asp=1, xlab="inferred x [m]", ylab="inferred y [m]",
     xlim=c(0,2400))
points(0, 0, pch='x')
mtext(sprintf("ele %.0fm   alt %.0fdeg   azi %.0fdeg   fov %.0fdeg",
              elevation, altitude, azimuth, fov), line=-1, cex=.7)
cat(names(o$par), file='fit.out')
cat('\n', file='fit.out', append=TRUE)
cat(o$par, file='fit.out', append=TRUE)
cat('\n', file='fit.out', append=TRUE)
