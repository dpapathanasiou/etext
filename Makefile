all:	pandp.pdf pandp-f.pdf \
	sense.pdf sense-f.pdf \
	mansf.pdf mansf-f.pdf \
	2city.pdf 2city-f.pdf \
	1noam.pdf 1noam-f.pdf \
	emma.pdf emma-f.pdf \
	cdscs.pdf cdscs-f.pdf

%.pdf : %.ps
	ps2pdf -dAutoRotatePages=/None $< $@

%.ps : %.tex
	rm -f $*.{aux,toc}
	pdflatex "\pdfoutput=0 \def\onesided{} \input $<"
	pdflatex "\pdfoutput=0 \def\onesided{} \input $<"
	dvips -T5.25in,8in -o $*.ps $*.dvi

%-f.ps : %.tex
	rm -f $*.{aux,toc}
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	pdflatex "\pdfoutput=0 \def\nocolor{} \input $<"
	dvips -T5.25in,8in -o $*-tmp.ps $*.dvi
	psbook -q -s4 <$*-tmp.ps | pstops -q '4:0L(8.25in,0.125in)+1L(8.25in,5.625in),2R(0.25in,10.875in)+3R(0.25in,5.375in)' >$*-f.ps

clean:
	rm -f *.dvi *.pdf *.ps *.aux *.log *.toc *~
