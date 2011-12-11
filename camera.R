if (!interactive())
    png("camera.png", width=800, height=400)
library(oce)
source('proj.R')
cameraLat <- 44.634719170
cameraLon <- -63.571794927
Ni <- 50
Nj <- 50
i <- rep(1:Ni, each=Nj)
j <- rep(1:Nj, Ni)
col <- rep(oceColorsJet(Ni), times=Nj)
Vi <- 30
D <- proj(i, j, elevation=10, altitude=0, azimuth=0, Vi, Ni, Nj)
par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,.7,0), pch=3)
plot(i, j, asp=1, col=col, xlab="pixel i", ylab="pixel j")
## sample to avoid overplotting
r <- sample(1:length(D$Di))
plot((D$Di)[r], (D$Dj)[r], asp=1, col=col[r], xlab="x [m]", ylab="y [m]",
     ylim=c(0, 1e3))
