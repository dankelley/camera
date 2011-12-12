library(oce)
source('proj.R')
cameraLat <- 44.634719170
cameraLon <- -63.571794927
data(coastlineHalifax)
## camera at 44.634719170 -63.571794927
imageHeight <- 1680
gcp <- read.table('P1020248-gcp.dat', header=TRUE)
gcp$i <- gcp$xpix
gcp$j <- imageHeight - gcp$ypix

par(mfrow=c(2,2))

## lat-lon map
plot(coastlineHalifax, center=c(-63.56, 44.640), span=4)
points(gcp$lon, gcp$lat)
points(cameraLon, cameraLat, pch='x')
##text(gcp$lon, gcp$lat, 1:length(gcp$lon), pos=1)

## xy map
xy <- geodXy(gcp$lat, gcp$lon, cameraLat, cameraLon)
plot(xy, asp=1, xlab="map x [m]", ylab="map y [m]", xlim=c(0,2500))
points(0, 0, pch='x')

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
plot(coastlineHalifax, center=c(-63.56, 44.640), span=4)
points(predLon, predLat)
points(cameraLon, cameraLat, pch='x')

plot(pred$x, pred$y, asp=1, xlab="inferred x [m]", ylab="inferred y [m]",
     xlim=c(0,2400))
points(0, 0, pch='x')
mtext(sprintf("ele %.0fm   alt %.0fdeg   azi %.0fdeg   fov %.0fdeg",
              elevation, altitude, azimuth, v), line=-1, cex=.7)
print(o)

