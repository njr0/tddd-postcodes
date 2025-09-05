all:	n_plausible_postcodes1.pdf \
        n_plausible_postcodes2.pdf \
        n_plausible_postcodes3.pdf

clean:
	rm -f *.pdf *.aux *.log *.html

.PHONY:
1: n_plausible_postcodes1.pdf

n_plausible_postcodes1.pdf: n_plausible_postcodes1.qmd
	quarto render n_plausible_postcodes1.qmd --to pdf
	quarto render n_plausible_postcodes1.qmd
	cp n_plausible_postcodes1.html n_plausible_postcodes1.pdf ../../output

n_plausible_postcodes2.pdf: n_plausible_postcodes2.qmd \
        _n_plausible_postcodes.py.qmd
	quarto render n_plausible_postcodes2.qmd --to pdf

_n_plausible_postcodes.py.qmd: n_plausible_postcodes.py PRE POST
	cat PRE n_plausible_postcodes.py POST > _n_plausible_postcodes.py.qmd

n_plausible_postcodes3.pdf: n_plausible_postcodes3.tex \
                            n_plausible_postcodes.txt \
                            test_sh_n_plausible_postcodes_sh.py \
                            ref/sh_n_plausible_postcodes_sh/*
	python test_sh_n_plausible_postcodes_sh.py
	pdflatex n_plausible_postcodes3

n_plausible_postcodes3.txt: n_plausible_postcodes.py
	sh n_plausible_postcodes.sh
