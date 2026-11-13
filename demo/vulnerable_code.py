# DEMO ONLY: intentionally insecure code to prove CodeQL blocks the PR.
# Copy to app/vulnerable.py on a test branch.
import sqlite3
import subprocess
from flask import request

from app.main import app


@app.get("/user")
def get_user():
    user_id = request.args.get("id")
    conn = sqlite3.connect("users.db")
    # SQL injection: user input concatenated into the query
    cur = conn.execute("SELECT * FROM users WHERE id = " + user_id)
    return str(cur.fetchall())


@app.get("/ping")
def ping():
    host = request.args.get("host")
    # Command injection: user input passed to a shell
    return subprocess.check_output("ping -c 1 " + host, shell=True)
