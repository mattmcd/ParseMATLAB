class ParseError(Exception):
    '''Parse error at line, col'''
    
    def __init__(self, line, col, msg):
        self.line = line
        self.col = col
        self.msg = msg

    def __str__(self):
        return 'Error on line {line}, col {col}: {msg}'.format(
            line = self.line, col = self.col, msg = self.msg)
