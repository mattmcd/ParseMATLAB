from antlr4.error.ErrorListener import ErrorListener

class ParseErrorExceptionListener(ErrorListener):
    '''Raise exception when parse error happens'''
    INSTANCE = None

    def syntaxError(self, recognizer, offendingSymbol, line, col, msg, e):
        print 'Ooops!'
        # raise
