import flask
from flask import Flask, redirect, render_template, request, session, jsonify
from flask_mail import Mail, Message
from flask_session import Session
import os
import hashlib
import mysql.connector


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

@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response



@app.route("/")
def index():
    return render_template("index.html", css_link = "/static/css/home.css")


@app.route("/login", methods = ["POST"])
def login():
    if flask.request.method == "POST" :
        # Here we are adding a new user
        mydb = mysql.connector.connect(host = "localhost",
                                       user = "appUser",
                                       password = "password",
                                       database="stories")
        print(mydb)
        mycursor = mydb.cursor()
        response = None
        email = request.get_json()["email"]
        password = request.get_json()["password"]

        # Encode the password and the login
        encrypted_password = hashlib.sha256(password.encode("utf-8")).hexdigest()

        sql_to_check_dup = "SELECT password FROM USER WHERE email=%s;"
        mycursor.execute(sql_to_check_dup, [email], multi=True)
        results = mycursor.fetchall()
        if len(results) and results[0][0] == encrypted_password:
            session["user"] = email
            response = jsonify({"status": "OK"})
        elif len(results): 
            response = jsonify({"status": "WRONG PASSWORD"})
        else:
            response = jsonify({"status": "NONEXISTENT USER"})
        mydb.close()
        return response


@app.route("/logout")
def logout():
    session.pop("user", None)
    return redirect(request.referrer)


@app.route("/signed-up", methods = ["POST"])
def sign_up():
    mydb = mysql.connector.connect(host = "localhost",
                                    user = "appUser",
                                    password = "password",
                                    database="stories")
    cur = mydb.cursor()
    if flask.request.method == "POST" :
        response = None
        email = request.get_json()["email"]
        password = request.get_json()["password"]
        password = hashlib.sha256(password.encode("utf-8")).hexdigest()
        userType = request.get_json()["userType"]
        try:
            sql = "INSERT INTO USER(email, password, userType) VALUES(%s, %s, %s);"
            cur.execute(sql, [email, password, userType])
            mydb.commit()
            session["user"] = email
            print("returning index page")
            response = jsonify({"status": "OK"})
        except (mysql.connector.Error, mysql.connector.Warning):
            response = jsonify({"status": "USER EXISTS"})
    mydb.close()
    return response



@app.route("/stories")
def stories():
    mydb = mysql.connector.connect(host = "localhost",
                                        user = "appUser",
                                        password = "password",
                                        database="stories")
    cur = mydb.cursor()
    sql = "SELECT * FROM STORY LIMIT 4;"
    cur.execute(sql)
    results = cur.fetchall()
    stories = []

    for tuple in results:
        title = tuple[2]
        imageURL = tuple[5]
        storyID = tuple[0]
        stories.append({"imageURL": imageURL, "title": title, 'storyID': storyID})
    

    return render_template("stories.html", css_link="/static/css/story-cards.css",
                           stories=stories)


@app.route("/stories/<storyID>")
def story(storyID):
    mydb = mysql.connector.connect(host = "localhost",
                                    user = "appUser",
                                    password = 'password',
                                    database="stories")
    storyID = int(storyID)
    cur = mydb.cursor()
    sql = "SELECT * FROM STORY WHERE storyID=%s LIMIT 1;"
    cur.execute(sql, [storyID], multi=True)
    results = cur.fetchall()
    for tuple in results:
        textEnglish = tuple[3]
        textFrench = tuple[4]
        title = tuple[2]
    story = {"textEnglish": textEnglish, "textFrench": textFrench, 'title': title}

    return render_template("story.html", 
                           css_link="/static/css/one-story.css",
                           story = story)


@app.route("/submit-form", methods=["POST"])
def submit_form():
    user_email = request.get_json()["email"]
    firstname = request.get_json()["firstname"]
    lastname = request.get_json()["lastname"]
    message = request.get_json()["message"]
    formattedMessage = "Another contact us form has been submitted!\nName: %s %s\nEmail: %s\nMessage: %s" % (firstname, lastname, user_email, message)
    sendMessage = Message("Another submission!", body= formattedMessage,
                      sender= os.getenv("MAIL_DEFAULT_SENDER"), 
                      recipients=["sophiamalashenko@gmail.com"])
    mail.send(sendMessage)
    return ""



@app.route("/change-mode", methods = ["POST"]) 
def change_mode():
    session["mode"] = request.get_json()["mode"]
    print("!!!! This is the session" + session["mode"])
    return ""


