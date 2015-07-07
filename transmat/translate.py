from antlr4 import *
from parse.MATLABLexer import MATLABLexer
from parse.MATLABParser import MATLABParser
from TranslateListener import TranslateListener

def main(argv):

    input = "function y = foo(x)\n"

    chars = InputStream.InputStream(input);
    lexer = MATLABLexer(chars);
    tokens = CommonTokenStream(lexer);
    parser = MATLABParser(tokens);
    tree = parser.fileDecl();

    # Actually do the walking
    evaluator = TranslateListener();
    walker = ParseTreeWalker();
    walker.walk(evaluator, tree);

if __name__ == '__main__':
    import sys
    main(sys.argv)
