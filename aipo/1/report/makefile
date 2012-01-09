NAME=report

all: build

run: build
	evince $(NAME).pdf


build: $(NAME).pdf

$(NAME).pdf: $(NAME).tex listingi/ekstrema.rb listingi/grayscale1.rb listingi/grayscale2.rb listingi/histogram_grayscale.rb listingi/histogram.rb listingi/negate.rb listingi/tools_cut.rb
	pdflatex $(NAME).tex

clear:
	rm -f $(NAME).aux $(NAME).log $(NAME).dvi $(NAME).toc $(NAME).idx

