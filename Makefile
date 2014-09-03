.SUFFIXES: .ml
OC=ocamlopt
SOURCE= Main.ml
RESULT=imageFormatChecker

all: $(RESULT)

$(RESULT): $(SOURCE)
	$(OC) -o $@ $^

clean:
	rm -f $(RESULT) *.cmi *.cmx *.o
