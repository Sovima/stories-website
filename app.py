from flask import Flask, render_template, request, session
from flask_mail import Mail, Message
from flask_session import Session
import os

app = Flask(__name__)
# Configure mail settings
# app.config["MAIL_DEFAULT_SENDER"] = os.getenv("MAIL_DEFAULT_SENDER")
app.config["MAIL_PASSWORD"] = os.getenv("MAIL_PASSWORD")
app.config["MAIL_PORT"] = 587
app.config["MAIL_USE_TLS"] = True
app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_USERNAME"] = os.getenv("MAIL_USERNAME")
mail = Mail(app)

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

Session(app)

@app.route("/")
def index():
    return render_template("index.html", css_link = "/static/css/home.css")


@app.route("/stories")
def stories():
    return render_template("stories.html", css_link="/static/css/story-cards.css")


@app.route("/puss-in-boots")
def puss_in_boots():
    return render_template("puss-in-boots.html", css_link="/static/css/one-story.css")


@app.route("/", methods=["POST"])
def submit_form():
    user_email = request.form.get("email")
    message = Message("This is the test email sent from %s" % user_email, sender= os.getenv("MAIL_DEFAULT_SENDER"), 
                      recipients=["sophiamalashenko@gmail.com"])
    mail.send(message)
    return render_template("index.html", css_link = "/static/css/home.css")



@app.route("/change-mode", methods = ["POST"]) 
def func():
    session["mode"] = request.get_json()["mode"]
    print("!!!! This is the session" + session["mode"])
    return ""

