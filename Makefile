all: pdf clean

pdf: 
	rubber --pdf masc-thesis

clean:
	rubber --clean masc-thesis

purge:
	rm -rf masc-thesis.pdf