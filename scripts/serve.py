#!/usr/bin/env python
import SimpleHTTPServer
import sys

class MyHTTPRequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_my_headers()
        SimpleHTTPServer.SimpleHTTPRequestHandler.end_headers(self)

    def send_my_headers(self):
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")


if __name__ == '__main__':
    if '--no-cache' in sys.argv:
        sys.argv.remove('--no-cache')
        SimpleHTTPServer.test(HandlerClass=MyHTTPRequestHandler)
    else:
        SimpleHTTPServer.test()

