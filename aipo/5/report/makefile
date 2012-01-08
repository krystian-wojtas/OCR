NAME=report

all: build

run: build
	evince $(NAME).pdf


build: $(NAME).pdf

$(NAME).pdf: $(NAME).tex
	pdflatex $(NAME).tex

clear:
	rm -f $(NAME).aux $(NAME).log $(NAME).dvi $(NAME).toc $(NAME).idx

