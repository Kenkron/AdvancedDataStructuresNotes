formatting := fontsize=12pt
smallmargin := geometry:margin=1in
args := $(addprefix -V, $(formatting))
sources := $(wildcard */*.md)
dests := $(addsuffix .pdf, $(basename $(sources)))

%.pdf:
	pandoc $(args) $(addsuffix .md, $(basename $@)) -o $@

all:$(dests)

composite:
	for f in */*.md; do (cat $${f} ; echo "\pagebreak\n"); done | pandoc $(args) -o Notes.pdf

clean:
	rm -f */*.pdf
