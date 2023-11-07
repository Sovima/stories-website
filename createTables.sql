/*
Database and table creation, with necessary constraints
*/
CREATE DATABASE stories;
USE stories;
CREATE TABLE USER(email VARCHAR(255) NOT NULL,
                  lname VARCHAR(40) NULL,
                  fname VARCHAR(40) NULL,
                  password CHAR(64) NOT NULL,
                  CHECK (email LIKE '%_@__%.__%'),
                  CHECK (lname REGEXP '^[A-Za-z]+$'),
                  CHECK (fname REGEXP '^[A-Za-z]+$'),
                  PRIMARY KEY (email));

CREATE TABLE TEACHER(teacherID VARCHAR(255) NOT NULL,
                     email VARCHAR(255) NOT NULL,
                     PRIMARY KEY (teacherID),
                     FOREIGN KEY (email) REFERENCES USER(email));

CREATE TABLE STUDENT(studentID VARCHAR(255) NOT NULL,
                     email VARCHAR(255) NOT NULL,
                     PRIMARY KEY (studentID),
                     FOREIGN KEY (email) REFERENCES USER(email));

CREATE TABLE STORY(storyID VARCHAR(255) NOT NULL,
                   author VARCHAR(100) NULL,
                   storyName VARCHAR(255) NOT NULL,
                   textEnglish TEXT NOT NULL,
                   textFrench TEXT NOT NULL,
                   CHECK (author LIKE '%[a-zA-Z,.]%'),
                   PRIMARY KEY (storyID));

CREATE TABLE CLASS_TEACHER(classID CHAR(16) NOT NULL,
                           teacherID VARCHAR(255) NOT NULL,
                           CONSTRAINT classIDCheck CHECK (classID LIKE '%[0-9]%'),
                           PRIMARY KEY (classID),
                           FOREIGN KEY (teacherID) REFERENCES TEACHER(teacherID));

CREATE TABLE ASSIGNMENT(AssignmentNum TINYINT NOT NULL,
                        classID CHAR(16) NOT NULL,
                        storyID VARCHAR(255) NOT NULL,
                        deadlineDate DATE NULL,
                        deadlineTime TIME NULL,
                        PRIMARY KEY (AssignmentNum, classID),
                        FOREIGN KEY (classID) REFERENCES CLASS_TEACHER(classID),
                        FOREIGN KEY (storyID) REFERENCES STORY(storyID));

CREATE TABLE CLASSES(classID CHAR(16) NOT NULL,
                     studentID VARCHAR(255) NOT NULL,
                     PRIMARY KEY (classID, studentID),
                     FOREIGN KEY (classID) REFERENCES CLASS_TEACHER(classID),
                     FOREIGN KEY (studentID) REFERENCES STUDENT(studentID));

CREATE TABLE ASSIGNMENT_STATUS(studentID VARCHAR(255) NOT NULL, 
                               assignmentNum TINYINT NOT NULL,
                               classID CHAR(16) NOT NULL,
                               completionStatus VARCHAR(255) NOT NULL,
                               CHECK (completionStatus in 
                                       ('Started', 'Completed', 
                                       'Not Started')),
                               PRIMARY KEY (studentID, assignmentNum, classID),
                               FOREIGN KEY (AssignmentNum, classID) REFERENCES
                                            ASSIGNMENT(AssignmentNum, classID),
                               FOREIGN KEY (studentID) REFERENCES STUDENT(studentID));




/*
Altering tables
*/

ALTER TABLE CLASS_TEACHER 
      DROP CONSTRAINT classIDCheck;
ALTER TABLE CLASS_TEACHER 
      ADD CONSTRAINT classIDCheck CHECK (classID LIKE '%[0-9A-Z]%');




/*
Populating tables
*/
INSERT INTO USER VALUES ('user1@email.test', 'Mayer', 'John', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
INSERT INTO USER VALUES ('user2@email.test', 'Sofya', 'Malashcs', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5');
INSERT INTO USER VALUES ('user3@email.test', 'Jessica', 'James', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');
INSERT INTO USER VALUES ('user4@email.test', 'Kim', 'K', '8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414');
INSERT INTO USER VALUES ('user5@email.test', 'Bart', 'Simpson', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f');
INSERT INTO USER (email, password) VALUES ('user6@email.test', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225');
INSERT INTO USER VALUES ('user7@email.test', 'John', 'Frusciante', 'f14f286ca435d1fa3b9d8041e8f06aa0af7ab28ea8edcd7e11fd485a100b632b');
INSERT INTO USER VALUES ('user8@email.test', 'Josh', 'Klinghoffer', 'b27dfc00528b59c53de1183a1910ee7dd9d0847247b995fbfd0e843669205638');
INSERT INTO USER (email, password) VALUES ('user9@email.test', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5');
INSERT INTO USER VALUES ('user10@email.test', 'Bart', 'Simpson', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');
INSERT INTO USER VALUES ('user11@email.test', 'Best', 'User', '472bbe83616e93d3c09a79103ae47d8f71e3d35a966d6e8b22f743218d04171d');
INSERT INTO USER (email, password) VALUES ('user12@email.test', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f');

/*
Creating views tables
*/

CREATE VIEW USER_INFO AS
SELECT USER.email, USER.lname, USER.fname
FROM USER;

CREATE VIEW CLASS_1_STUDENTS AS
SELECT studentID
FROM CLASSES
WHERE classID = '0000000000000001';


