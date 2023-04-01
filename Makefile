SHELL = /bin/sh
SOURCES = $(shell ls *.tex | egrep -v gutenberg-)
TARGETS = $(SOURCES:.tex=.pdf)

all:	$(TARGETS)

%.pdf : %.ps
	ps2pdf -dAutoRotatePages=/None $< $@

%.ps : %.tex
	rm -f $*.{aux,toc}
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	dvips -T5.25in,8in -o $*-tmp.ps $*.dvi
	psbook -q -s4 <$*-tmp.ps | pstops -q '4:0L(8.25in,0.125in)+1L(8.25in,5.625in),2R(0.25in,10.875in)+3R(0.25in,5.375in)' >$*.ps

clean:
	rm -f $(TARGETS) *.dvi *.ps *.log *.out *.aux *.toc *~

tidy:
	rm -f *~ *.dvi *.ps *.log *.out *.aux *.toc