import re
import sha
import base64
from wsgiref.simple_server import make_server

# http://www.teria.com/~koseki/tools/wssegen/
USER = 'sample'
PASSWD = 'passwd'


def generate_digest(password, nonce64, created):
    nonce_str = base64.decodestring(nonce64)
    passdigest = sha.sha(nonce_str + created + password).digest()
    return base64.encodestring(passdigest).strip()


def get_credential(text):
    patern = r'UsernameToken Username=\"(.+)\", PasswordDigest="(.+)", ' + \
              'Nonce="(.+)", Created="(.+)"'
    return re.compile(patern).findall(text)[0]


def app(environ, start_response):
    header = environ.get('HTTP_X_WSSE')
    (user, digest, nonce, created) = get_credential(header)

    start_response('200 OK', [('Content-Type', 'text/plain')])

    if user == USER and \
       digest == generate_digest(PASSWD, nonce, created):
        yield 'OK\n'
    else:
        yield 'NG\n'


if __name__ == '__main__':
    httpd = make_server('', 8000, app)
    print "Serving HTTP on port 8000..."
    httpd.serve_forever()
