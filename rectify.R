library(oce)
library(ReadImages)
source('proj.R')
data(coastlineHalifax)
fit <- read.table('fit.out', header=TRUE)
im <- read.jpeg("P1020248.jpg")
#plot(im)
##col <- as.vector(rgb(im[,,1], im[,,2], im[,,3]))

## first index (i say) runs 1:nrow(im)=1680 (vertically) WTF
## second index (j say) runs 1:ncol(im)=2240 (horizontally) WTF
nrows <- nrow(im)
ncols <- ncol(im)
ivec <- rep(1:nrows, ncols)
jvec <- rep(1:ncols, each=nrows)
##col <- rgb(t(im[,,1]), t(im[,,2]), t(im[,,3]))
col <- rgb(im[,,1], im[,,2], im[,,3])
dim(col) <- dim(im)[1:2]
col <- as.vector(t(col))
p <- proj(ivec, jvec, fit$elevation, fit$altitude, fit$azimuth, fit$fov)
r <- sample(1:length(p$x))
pLat <- cameraLat + p$y[r] / 111e3 
pLon <- cameraLon + p$x[r] / 111e3 / cos(cameraLat * pi / 180)
load('sea.rda')
seaFit <- proj(sea$x, sea$y, fit$elevation, fit$altitude, fit$azimuth, fit$fov)
seaLat <- cameraLat + seaFit$y / 111e3 
seaLon <- cameraLon + seaFit$x / 111e3 / cos(cameraLat * pi / 180)
plot(pLon, pLat, col=col[r], asp=1 / cos(cameraLat * pi / 180),pch=20, cex=1, xlim=c(-63.567,-63.56), ylim=c(44.63478, 44.64))
     #xlim=range(seaLon), ylim=range(seaLat))
lines(seaLon, seaLat, col='red')
warning("do I have length of y mixed up?? colors seem to be too patchy")
