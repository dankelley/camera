all: camera.out fit1.out fit2.out
%.out:%.R
	R --no-save < $< > $@

