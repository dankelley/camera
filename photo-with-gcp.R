if (!interactive())
    png("photo-with-gcp.png", width=2240, height=1680)
library(oce)
library(ReadImages)
par(mar=rep(0, 4))
gcp <- read.table('P1020248-gcp.dat', header=TRUE)
im <- read.jpeg("P1020248.jpg")
plot(im)
imageHeight <- 1680
gcp$i <- gcp$xpix
gcp$j <- imageHeight - gcp$ypix
points(gcp$i, gcp$j, col='white', pch=20, cex=3)
points(gcp$i, gcp$j, col='red', pch=20, cex=2)
points(gcp$i, gcp$j, col='white', pch=20, cex=1)

