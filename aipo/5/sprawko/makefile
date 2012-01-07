NAZWA=sprawko

all: build

run: build
	evince $(NAZWA).pdf


build: $(NAZWA).pdf

$(NAZWA).pdf: $(NAZWA).tex
	pdflatex $(NAZWA).tex

clear:
	rm -f $(NAZWA).aux $(NAZWA).log $(NAZWA).dvi $(NAZWA).toc $(NAZWA).idx

