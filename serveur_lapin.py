#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Petit serveur local pour la page "nouvel onglet lapin".

Les extensions Firefox n'ont plus le droit d'ouvrir un fichier local
(file:///...), mais elles peuvent ouvrir http://127.0.0.1:8765/ .
Ce script sert donc la page depuis le reseau local uniquement.

Utilisation :
    python serveur_lapin.py          -> demarre le serveur
    python serveur_lapin.py --check  -> code 0 si le serveur tourne deja
    python serveur_lapin.py --stop   -> arrete le serveur
"""

import http.server
import os
import socket
import subprocess
import sys
import tempfile

HOST = "127.0.0.1"
PORT = 8765
ROOT = os.path.dirname(os.path.abspath(__file__))
PAGE = "nouvel-onglet-lapin.html"
PIDFILE = os.path.join(tempfile.gettempdir(), "lapin-nouvel-onglet.pid")

FAVICON = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">'
           '<text y=".9em" font-size="90">\U0001F430</text></svg>').encode("utf-8")


class Handler(http.server.BaseHTTPRequestHandler):
    server_version = "LapinOnglet/1.0"

    def _repond(self, code, ctype, data):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.send_header("Cache-Control", "no-store, no-cache, must-revalidate")
        self.end_headers()
        if self.command != "HEAD":
            try:
                self.wfile.write(data)
            except (BrokenPipeError, ConnectionResetError):
                pass

    def _page(self):
        chemin = os.path.join(ROOT, PAGE)
        try:
            with open(chemin, "rb") as f:
                return f.read()
        except OSError:
            return None

    def do_GET(self):
        chemin = self.path.split("?", 1)[0].split("#", 1)[0]
        if chemin in ("/", "/index.html", "/" + PAGE, "/nouvel-onglet-lapin"):
            data = self._page()
            if data is None:
                self._repond(500, "text/plain; charset=utf-8",
                             ("Page introuvable : %s" % PAGE).encode("utf-8"))
            else:
                self._repond(200, "text/html; charset=utf-8", data)
        elif chemin == "/favicon.ico":
            self._repond(200, "image/svg+xml", FAVICON)
        else:
            self._repond(404, "text/plain; charset=utf-8", b"404 - rien ici")

    do_HEAD = do_GET

    def log_message(self, *args):
        pass  # silencieux


def en_ligne():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.settimeout(0.4)
        return s.connect_ex((HOST, PORT)) == 0


def arreter():
    try:
        with open(PIDFILE, "r", encoding="utf-8") as f:
            pid = int(f.read().strip())
    except (OSError, ValueError):
        print("Aucun serveur lapin en cours d'execution.")
        return 1

    subprocess.run(["taskkill", "/PID", str(pid), "/F"],
                   capture_output=True, check=False)
    try:
        os.remove(PIDFILE)
    except OSError:
        pass
    print("Serveur lapin arrete.")
    return 0


def main():
    if "--check" in sys.argv:
        return 0 if en_ligne() else 1

    if "--stop" in sys.argv:
        return arreter()

    if en_ligne():
        print("Le serveur lapin tourne deja : http://%s:%d/" % (HOST, PORT))
        return 0

    try:
        serveur = http.server.ThreadingHTTPServer((HOST, PORT), Handler)
    except OSError as e:
        print("Impossible d'ouvrir le port %d : %s" % (PORT, e))
        return 1

    with open(PIDFILE, "w", encoding="utf-8") as f:
        f.write(str(os.getpid()))

    print("Page lapin servie sur http://%s:%d/" % (HOST, PORT))
    print("Ctrl+C pour arreter.")
    try:
        serveur.serve_forever()
    except KeyboardInterrupt:
        print("\nArret du serveur lapin.")
    finally:
        serveur.server_close()
        try:
            os.remove(PIDFILE)
        except OSError:
            pass
    return 0


if __name__ == "__main__":
    sys.exit(main())
