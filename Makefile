pdfs:	postcodes1.pdf \
        postcodes2.pdf
#        postcodes3.pdf

first: cleaner gentest test rustedtest diffs postcodes.txt pdfs

clean:
	rm -f *.pdf *.aux *.log *.html
	cp letters26.py letters.py

cleaner: clean
	rm -rf ref *.txt

postcodes1.pdf: postcodes1.qmd
	quarto render postcodes1.qmd --to pdf
	quarto render postcodes1.qmd
	cp postcodes1.html postcodes1.pdf ../../tdda/output

postcodes2.pdf: postcodes2.qmd \
                _postcodes.py.qmd \
                test
	quarto render postcodes2.qmd --to pdf

_postcodes.py.qmd: postcodes.py PRE POST
	cat PRE postcodes.py POST > _postcodes.py.qmd

postcodes3.pdf: postcodes3.tex test
	pdflatex postcodes3

postcodes.txt: restore postcodes.py letters.py
	python postcodes.py > postcodes.txt

test: restore
	python test_python_postcodes_py.py > test-output.txt 2>&1

rustedtest:
	cp letters52.py letters.py
	-python test_python_postcodes_py.py > test-output-fail.txt 2>&1
	cp letters26.py letters.py

gentest:
	tdda gentest 'python postcodes.py'  > gentest-output.txt 2>&1

diffs:
	-diff postcodes-defs.tex ref/python_postcodes_py/postcodes-defs.tex \
              > diff-output.txt
	-diff postcodes.json ref/python_postcodes_py/postcodes.json \
              >> diff-output.txt

restore:
	cp letters26.py letters.py
