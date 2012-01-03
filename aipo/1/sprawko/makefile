NAZWA=sprawko

all: run

run: build
	evince $(NAZWA).pdf


build: $(NAZWA).pdf

$(NAZWA).pdf: $(NAZWA).tex listingi/*.rb
	pdflatex $(NAZWA).tex

clear:
	rm -f $(NAZWA).aux $(NAZWA).log $(NAZWA).dvi $(NAZWA).toc $(NAZWA).idx

