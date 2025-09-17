pdfs: postcodes1.pdf \
      postcodes2.pdf \
      postcodes1bad.pdf \
      postcodes2rusted-fail.pdf
#     postcodes3.pdf

first: cleaner postcodes.txt gentest test-correct \
       rustedtest diffs


clean: restore
	rm -f *.pdf *.aux *.log *.html \
              postcodes1bad.qmd postcodes2rusted-fail.qmd

cleaner: clean
	rm -rf ref *.txt

postcodes1.pdf: postcodes1.qmd
	quarto render postcodes1.qmd
	cp postcodes1.html postcodes1.pdf ../../tdda/output

postcodes2.pdf: test \
                postcodes2.qmd \
                _postcodes.py.qmd
	quarto render postcodes2.qmd

_postcodes.py.qmd: postcodes.py PRE POST
	cat PRE postcodes.py POST > _postcodes.py.qmd


postcodes1bad.pdf: postcodes1.qmd
	cp letters52.py letters.py
	cp postcodes1.qmd postcodes1bad.qmd
	quarto render postcodes1bad.qmd
	cp letters26.py letters.py

postcodes2rusted-fail.pdf: postcodes2.qmd _postcodes.py.qmd
	cp letters52.py letters.py
	cp postcodes2.qmd postcodes2rusted-fail.qmd
	-quarto render postcodes2rusted-fail.qmd > postcodes2rusted-fail.txt 2>&1
	cp letters26.py letters.py

postcodes3.pdf: postcodes3.tex test
	pdflatex postcodes3

postcodes.txt: restore postcodes.py letters.py
	python postcodes.py > postcodes.txt

test-correct: restore
	python test_python_postcodes_py.py > test-output.txt 2>&1

test:
	python test_python_postcodes_py.py

rustedtest:
	cp letters52.py letters.py
	-python test_python_postcodes_py.py > test-output-fail.txt 2>&1
	cp letters26.py letters.py

gentest:
	tdda gentest 'python postcodes.py'  > gentest-output.txt 2>&1

diffs:
	-diff postcodes.json ref/python_postcodes_py/postcodes.json \
              > diff-json-output.txt
	-diff postcodes-defs.tex ref/python_postcodes_py/postcodes-defs.tex \
              > diff-tex-output.txt

restore:
	cp letters26.py letters.py
