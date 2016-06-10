sources := $(wildcard */*.md)
dests := $(addsuffix .pdf, $(basename $(sources)))

%.pdf:
	pandoc -V geometry:margin=1in -V fontsize=12pt $(addsuffix .md, $(basename $@)) -o $@

all:$(dests)

clean:
	rm -f */*.pdf
