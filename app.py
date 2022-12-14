from flask import Flask, render_template, request
from flask_mail import Mail, Message
import os

app = Flask(__name__)
# Configure mail settings
app.config["MAIL_DEFAULT_SENDER"] = os.getenv("MAIL_DEFAULT_SENDER")
app.config["MAIL_PASSWORD"] = os.getenv("MAIL_PASSWORD")
app.config["MAIL_PORT"] = 587
app.config["MAIL_USE_TLS"] = True
app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_USERNAME"] = os.getenv("MAIL_USERNAME")


mail = Mail(app)



@app.route("/")
def index():
    return render_template("index.html", css_link = "/static/css/home.css")


@app.route("/stories")
def stories():
    return render_template("stories.html", css_link="/static/css/story-cards.css")


@app.route("/puss-in-boots")
def puss_in_boots():
    return render_template("puss-in-boots.html", css_link="/static/css/one-story.css")