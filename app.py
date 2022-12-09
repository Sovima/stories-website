from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")


@app.route("/stories")
def stories():
    return render_template("stories.html")


@app.route("/puss-in-boots")
def puss_in_boots():
    return render_template("puss-in-boots.html")