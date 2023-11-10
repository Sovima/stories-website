import sqlite3
import flask
from flask import Flask, redirect, render_template, request, session, jsonify
from flask_mail import Mail, Message
from flask_session import Session
import os
import hashlib
from pymongo import MongoClient # will be using mysql connector instead
import random
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
                                       user = "root",
                                       password = os.getenv("MYSQL_PASS"),
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
    connection = sqlite3.connect("login.db")
    cur = connection.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS users (Email TEXT, Password TEXT);")
    if flask.request.method == "POST" :
        response = None
        email = request.get_json()["email"]
        password = request.get_json()["password"]
        userType = request.get_json()["userType"]
        if userType == "Teacher":
            # This class ID will be later 
            # put in a database
            classIDNew = random.randint(0,999999)

        sql_to_check_dup = "SELECT COUNT(1) FROM users WHERE Email = ?;"
        check_out = cur.execute(sql_to_check_dup, [email]).fetchone()[0]
        if check_out == 0:
            encrypted_password = hashlib.sha256(password.encode("utf-8")).hexdigest()
            encrypted_email = hashlib.sha256(email.encode("utf-8")).hexdigest()
            sql = "INSERT INTO users(Email, Password) VALUES(?, ?);"
            cur.execute(sql, [encrypted_email, encrypted_password])
            connection.commit()
            session["user"] = email
            connection.close()
            print("returning index page")
            response = jsonify({"status": "OK"})
        else: 
            response = jsonify({"status": "USER EXISTS"})
    connection.close()
    return response



@app.route("/stories")
def stories():
    return render_template("stories.html", css_link="/static/css/story-cards.css")


@app.route("/puss-in-boots")
def puss_in_boots():
    return render_template("puss-in-boots.html", css_link="/static/css/one-story.css")


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





