showPhoto <- FALSE
library(ReadImages)
library(oce)
source('proj.R')
data(coastlineHalifax)
## camera at 44.634719170 -63.571794927
imageHeight <- 1680
gcp <- read.table('gcp-2010248.dat', header=TRUE)
gcp$i <- gcp$xpix
gcp$j <- imageHeight - gcp$ypix

if (showPhoto) par(mfrow=c(2,2)) else par(mfrow=c(1,3))

## lat-lon map
plot(coastlineHalifax, center=c(-63.56, 44.640), span=4)
points(gcp$lon, gcp$lat, pch=20, cex=3, col='white')
text(gcp$lon, gcp$lat, 1:length(gcp$lon))

## xy map
xy <- geodXy(gcp$lat, gcp$lon, cameraLat, cameraLon)
plot(xy, pch=20, cex=3, col='white', xlab="x [m]", ylab="y [m]")
text(xy$x, xy$y, 1:length(xy$x))

## 
p <- proj(gcp$i, gcp$j, elevation=30, altitude=-10, azimuth=0, Vi=40)
plot(p$Di, p$Dj, pch=20, cex=2, col='white')
text(p$Di, p$Dj, 1:length(p$Di))
if (showPhoto) {
    if (0 == length(ls(pattern='^im$')))
        im <- read.jpeg("P1020248.JPG")
    par(mar=rep(0.5, 4))
    plot(im)
    points(p$i, p$j, col='white', pch=20, cex=3)
    text(p$i, p$j, 1:length(p$i))
}
