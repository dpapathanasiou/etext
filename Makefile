SHELL = /bin/sh
SOURCES = $(shell ls *.tex | egrep -v gutenberg-)
TARGETS = $(SOURCES:.tex=.pdf)

all:	$(TARGETS)

%.pdf : %.ps
	ps2pdf -sPAPERSIZE=a4 -dAutoRotatePages=/None $< $@

%.ps : %.tex
	rm -f $*.{aux,toc}
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	dvips -t a4 -o $*-tmp.ps $*.dvi
	psbook -q -s4 <$*-tmp.ps | pstops -q '4:0L(203.65mm,3.175mm)+1L(203.65mm,151.175mm),2R(6.35mm,293.825mm)+3R(6.35mm,144.825mm)' >$*.ps

clean:
	rm -f $(TARGETS) *.dvi *.ps *.log *.out *.aux *.toc *~

tidy:
	rm -f *~ *.dvi *.ps *.log *.out *.aux *.toc