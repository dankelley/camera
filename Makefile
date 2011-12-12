all: camera.out fit.out fit2.out
%.out:%.R
	R --no-save < $< > $@

