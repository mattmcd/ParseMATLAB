from antlr4 import InputStream, CommonTokenStream, ParseTreeWalker 
from parse.MATLABLexer import MATLABLexer
from parse.MATLABParser import MATLABParser
from TranslateListener import TranslateListener
from ParseErrorExceptionListener import ParseErrorExceptionListener

def main(argv):

    input = "function y = foo(x)\n"

    chars = InputStream.InputStream(input)
    lexer = MATLABLexer(chars)
    tokens = CommonTokenStream(lexer)
    parser = MATLABParser(tokens)
    try:
        # Remove existing console error listener
        # NB: as of 20150708 pip install of antlr4 needs Recognizer.py to be patched
        # to add the removeErrorListener methods 
        parser.removeErrorListeners()
    except:
        pass
    # Throw if parse fails
    parser.addErrorListener(ParseErrorExceptionListener())
    errorDispatch = parser.getErrorListenerDispatch()
    print errorDispatch.delegates
    tree = parser.fileDecl();

    # Actually do the walking
    evaluator = TranslateListener();
    walker = ParseTreeWalker();
    walker.walk(evaluator, tree);

if __name__ == '__main__':
    import sys
    main(sys.argv)
