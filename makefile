sources := $(wildcard */*.md)
dests := $(addsuffix .pdf, $(basename $(sources)))

%.pdf:
	pandoc $(addsuffix .md, $(basename $@)) -o $@

all: $(dests)

clean:
	rm -f */*.pdf
