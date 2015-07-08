from antlr4.error.ErrorListener import ErrorListener
from Errors import ParseError

class ParseErrorExceptionListener(ErrorListener):
    '''Raise exception when parse error happens'''

    # Default instance
    INSTANCE = None

    def syntaxError(self, recognizer, offendingSymbol, line, col, msg, e):
        raise ParseError(line, col, msg)

ParseErrorExceptionListener.INSTANCE = ParseErrorExceptionListener()
