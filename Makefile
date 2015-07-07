all: java/MATLABParser.java transmat/parse/MATLABParser.py

python: transmat/parse/MATLABParser.py

install_python: 
	pip install -r requirements.txt

java/MATLABParser.java: MATLAB.g4
	antlr4 -o java MATLAB.g4
	
java/MATLABParser.class: java/MATLABParser.java
	javac java/*.java

transmat/parse/MATLABParser.py: MATLAB.g4
	antlr4 -o transmat/parse -Dlanguage=Python2 MATLAB.g4
	touch transmat/__init__.py
	touch transmat/parse/__init__.py

OUTDIRS = java transmat/parse
clean:
	for OUTDIR in $(OUTDIRS); do rm -f $$OUTDIR/* ; done

grun= java -cp java:$$CLASSPATH org.antlr.v4.runtime.misc.TestRig
.PHONY: test
test: java/MATLABParser.class
	$(grun) MATLAB fileDecl -tokens test.txt

testpy:
	python transmat/translate.py
