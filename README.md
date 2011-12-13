# Camera facts

* image size (7.144 x 5.358 mm)
  http://www.dpreview.com/products/panasonic/compacts/panasonic_dmclc40

* photo P2010248.JPG focal length 10.87

* therefore angle of view alpha = 2*atan(d / (2f)) is

    > 2*atan(7.144 / 2 / 10.87) * 180/pi

    [1] 36.38217


# File list

* ``camera.R``: First test of fitting pixel to xy.

* ``fit1.R``: Demonstration of fitting of pixel to xy, with ground control points.

* ``fit2.R``: As fit1.R but shows photo (slow).

* ``P1020248-gcp.dat``: ground-control points, including pixels from
  P1020248.jpg as well as latlon pairs from google earth (see ``latlon-*.png``)

* ``P1020248.jpg``: a photo

* ``latlon-*.png``: snapshots of google earth latlon, showing control points

