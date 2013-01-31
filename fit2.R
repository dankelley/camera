png("fit2.png", width=1200, height=300)
library(oce)
library(ReadImages)
source('proj.R')
cameraLat <- 44.634719170
cameraLon <- -63.571794927
data(coastlineHalifax)
## camera at 44.634719170 -63.571794927
imageHeight <- 1680
gcp <- read.table('P1020248-gcp.dat', header=TRUE)
gcp$i <- gcp$xpix
gcp$j <- imageHeight - gcp$ypix
xy <- geodXy(gcp$lat, gcp$lon, cameraLat, cameraLon)

par(mfrow=c(1,3))

## lat-lon map
plot(coastlineHalifax, clon=-63.56, clat=44.640, span=4)
points(gcp$lon, gcp$lat)
points(cameraLon, cameraLat, pch='x')
##text(gcp$lon, gcp$lat, 1:length(gcp$lon), pos=1)

im <- read.jpeg("P1020248.jpg")
plot(im)
points(gcp$i, gcp$j, col='white', pch=20, cex=3)
points(gcp$i, gcp$j, col='red', pch=20, cex=2)
points(gcp$i, gcp$j, col='white', pch=20, cex=1)

elevationVec <- altitudeVec <- azimuthVec <- vVec <- NULL
misfit <- function(p)
{
    elevationVec <<- c(elevationVec, p[1])
    altitudeVec <<- c(altitudeVec, p[2])
    azimuthVec <<- c(azimuthVec, p[3])
    vVec <<- c(vVec, p[4])
    p <- proj(gcp$i, gcp$j, elevation=p[1], altitude=p[2], azimuth=p[3], v=p[4])
    sqrt(mean((xy$x - p$x)^2 + (xy$y - p$y)^2, na.rm=TRUE))
}
o <- optim(c(30, -20, -30, 40), misfit)
elevation <- o$par[1]
altitude <- o$par[2]
azimuth <- (o$par[3])
v <- o$par[4]

## show prediction
pred <- proj(gcp$i, gcp$j, elevation, altitude, azimuth, v)
predLat <- cameraLat + pred$y / 111e3
predLon <- cameraLon + pred$x / 111e3 / cos(cameraLat * pi / 180)
plot(coastlineHalifax, clon=-63.56, clat=44.640, span=4)
points(predLon, predLat)
points(cameraLon, cameraLat, pch='x')
