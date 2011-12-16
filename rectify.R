library(oce)
library(ReadImages)
source('proj.R')
data(coastlineHalifax)
fit <- read.table('fit.out', header=TRUE)
im <- read.jpeg("P1020248.jpg")
#plot(im)
col <- rgb(im[,,1], im[,,2], im[,,3])

## first index (i say) runs 1:nrow(im)=1680 (vertically) WTF
## second index (j say) runs 1:ncol(im)=2240 (horizontally) WTF
imat <- rep(1:nrows, ncols)
jmat <- rep(1:ncols, each=nrows)
p <- proj(imat, jmat, fit$elevation, fit$altitude, fit$azimuth, fit$fov)
L <- 2000
r <- sample(1:length(p$x))
plot(p$x[r], p$y[r], col=col[r], asp=1, xlim=c(-L, L), ylim=c(-L, L), cex=1/5)
