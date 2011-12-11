proj <- function(i, j,
                 elevation, altitude, azimuth, v, # par
                 Ni=2240, Nj=1680,
                 trim=FALSE)
{
    ## degrees per pixel in x and y directions (i and j indices)
    dppx <- v / Ni
    dppy <- v / Nj
    ## x and y from geometry
    theta <- altitude + (j - Nj / 2) * dppy
    y <- -elevation / tan(theta * pi / 180)
    x <- y * tan(dppx * (i - Ni / 2) * pi / 180)
    ## rotate for azimuth
    C <- cos(-azimuth * pi / 180)
    S <- sin(-azimuth * pi / 180)
    R <- matrix(c(C, -S, S, C), nrow=2, byrow=TRUE)
    xy <- R %*% rbind(x, y)
    x <- xy[1,]
    y <- xy[2,]
    ## possibly trim points lying above the horizon
    if (trim) {
        Dj[theta >= 0] <- NA
        Di[theta >= 0] <- NA
    }
    list(i=i, j=j, x=x, y=y)
}

