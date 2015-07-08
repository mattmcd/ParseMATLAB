from transmat.translate import parse
from nose.tools import raises
from transmat.error.Errors import ParseError

def testFunDecl():
    in_str = '''\
function y=foo(x)
end
'''
    parse(in_str)

def testPartialFunDecl():
    in_str = '''\
function y=foo(x)
'''
    parse(in_str)

@raises(ParseError)
def testParseFail():
    in_str = '''\
function y=foo(x)

function a=bar(b)
end
'''
    parse(in_str)
