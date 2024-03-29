import os
import re
import io
import sys
import http.server
import socketserver

import qrcode

PORT = 8000


def get_ipaddress():
    cmd = "ifconfig"
    out = os.popen(cmd)
    for o in out:
        temp = re.findall(r"192.168.\d+.\d+", o)
        if temp:
            print(temp)
            return temp[0]


def print_ipaddress():
    url = f"http://{get_ipaddress()}:{PORT}"
    print(url)

    qr = qrcode.QRCode()
    qr.add_data(url)
    f = io.StringIO()
    qr.print_ascii(out=f)
    f.seek(0)
    print(f.read())


def run_server(dir_path):
    os.chdir(dir_path)

    Handler = http.server.SimpleHTTPRequestHandler
    try:
        httpd = socketserver.TCPServer(("", PORT), Handler)
        print("serving at port", PORT)
        httpd.serve_forever()
    except Exception as err:
        print(err)
        httpd.shutdown()


def main(dir_path="./"):
    print_ipaddress()
    run_server(dir_path)


if __name__ == "__main__":
    # pip install qrcode
    # qr "some string"
    args = sys.argv
    print(args)
    if len(args) > 1:
        main(args[1])
    else:
        main()
