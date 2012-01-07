NAME=report

all: run

run: build
	evince $(NAME).pdf


build: $(NAME).pdf

$(NAME).pdf: $(NAME).tex listingi/average.rb listingi/filter.rb listingi/thresholding_avl_g.rb listingi/thresholding_avl.rb listingi/thresholding.rb listingi/zoom.rb
	pdflatex $(NAME).tex

clear:
	rm -f $(NAME).aux $(NAME).log $(NAME).dvi $(NAME).toc $(NAME).idx

