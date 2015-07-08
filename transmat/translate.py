from antlr4 import InputStream, CommonTokenStream, ParseTreeWalker 
from parse.MATLABLexer import MATLABLexer
from parse.MATLABParser import MATLABParser
from TranslateListener import TranslateListener
from error.ErrorListener import ParseErrorExceptionListener
from error.Errors import ParseError

def translate(in_str):

    if in_str is None:
        in_str = "function y = foo(x)\n"

    chars = InputStream.InputStream(in_str)
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
    parser.addErrorListener(ParseErrorExceptionListener.INSTANCE)
    errorDispatch = parser.getErrorListenerDispatch()
    tree = parser.fileDecl();

    # Actually do the walking
    evaluator = TranslateListener();
    walker = ParseTreeWalker();
    walker.walk(evaluator, tree);

if __name__ == '__main__':
    import sys
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r') as f:
            in_str = f.read()
    else:
        in_str = None 
    translate(in_str)
