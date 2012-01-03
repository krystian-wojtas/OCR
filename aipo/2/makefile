all: raport

run:
	cd ..; ruby -I lib/ 1/lab.rb

raport: run
	cd sprawko; make
	mv sprawko/sprawko.pdf .
