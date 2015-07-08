from transmat.translate import parse
from nose.tools import raises
from transmat.error.Errors import ParseError
import os

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

def test_files():
    file_dir = os.path.join(os.path.dirname(__file__), 'parse_pass') 
    for f in [f for f in os.listdir(file_dir) if f.endswith('.m') ]:
        yield check_file, file_dir, f

def check_file(file_dir, f):
    with open(os.path.join(file_dir, f), 'r') as in_file:
      parse(in_file.read())
