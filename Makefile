#--------------------------------------------------
#  Makefile for uoyths
#
#  The main target is the uoyths.cls file, a
#  LaTeX class file for a University of York
#  style thesis document.
#
#  To build type:
#      make
#
#  To build documentation type:
#      make docs
#
#  To build exmaple files type:
#      make example
#
#-------------------------------------------------

INS_TEMP= COMPILE.bat \
			comp_bibunit.bat \
			example.bib \
			example.tex \
			lorem.tex \
			uoyths.bst \
			uoyths.log \

DTX_TEMP= uoyths.aux \
			uoyths.glo \
			uoyths.idx \
			uoyths.log

EXAMPLE_TEMP= bu*.aux \
			bu*.bbl \
			bu*.blg \
			bu.aux \
			bu.bbl \
			bu.blg \
			example.aux \
			example.glo \
			example.ist \
			example.log \
			example.maf \
			example.mtc \
			example.mtc* \
			example.nlo \
			example.toc


DIST_FILES= uoyths.cls \
			uoyths.dvi \
			uoyths_logo.eps \
			example.dvi


#--------------------------------------------------
#  Main
#-------------------------------------------------
.PHONY: all
all: uoyths.cls

uoyths.cls: uoyths.dtx uoyths.ins
	latex uoyths.ins


#--------------------------------------------------
#  Documentation
#-------------------------------------------------
.PHONY: docs
docs: uoyths.dvi

uoyths.dvi: uoyths.dtx
	latex uoyths.dtx
	latex uoyths.dtx


#--------------------------------------------------
#  Cleanup
#-------------------------------------------------
.PHONY: clean
clean:
	$(RM) -f ${INS_TEMP}
	$(RM) -f ${DTX_TEMP}
	$(RM) -f ${EXAMPLE_TEMP}

.PHONY: distclean
distclean: clean
	$(RM) -f ${DIST_FILES}


#--------------------------------------------------
#  Build example files
#-------------------------------------------------
.PHONY: example
example: example.dvi

example.dvi: example.tex uoyths.cls bu1.bbl
	latex example.tex
	latex example.tex

example.tex: uoyths.dtx uoyths.ins
	latex uoyths.ins

bu1.aux bu.aux: example.tex uoyths.cls
	latex example.tex

bu1.bbl: bu1.aux bu.aux
	@for bufile in bu*.aux; do \
		echo $$bufile; \
		bibtex $$bufile; \
	done

