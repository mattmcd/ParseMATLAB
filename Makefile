all: java/MATLABParser.java transmat/parse/MATLABParser.py

python: transmat/parse/MATLABParser.py

install_python: 
	pip install -r requirements.txt

java/MATLABParser.java: MATLABLexer.g4 MATLABParser.g4
	antlr4 -o java MATLABLexer.g4
	antlr4 -o java MATLABParser.g4
	
java/MATLABParser.class: java/MATLABParser.java
	javac java/*.java

transmat/parse/MATLABParser.py: MATLABLexer.g4 MATLABParser.g4
	antlr4 -o transmat/parse -Dlanguage=Python2 MATLABLexer.g4
	antlr4 -o transmat/parse -Dlanguage=Python2 MATLABParser.g4
	touch transmat/__init__.py
	touch transmat/parse/__init__.py

OUTDIRS = java transmat/parse
clean:
	for OUTDIR in $(OUTDIRS); do rm -f $$OUTDIR/* ; done

grun= java -cp java:$$CLASSPATH org.antlr.v4.runtime.misc.TestRig
.PHONY: test
test: java/MATLABParser.class
	$(grun) MATLABParser fileDecl -tokens test.txt

testpy:
	python transmat/translate.py
