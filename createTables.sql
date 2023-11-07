/*
Database and table creation, with necessary constraints
*/
CREATE DATABASE stories;
USE stories;
CREATE TABLE USER(email VARCHAR(255) NOT NULL,
                  lname VARCHAR(40) NULL,
                  fname VARCHAR(40) NULL,
                  password VARCHAR(255) NOT NULL,
                  CHECK (email LIKE '%_@__%.__%'),
                  CHECK (lname LIKE '%[^a-zA-Z]%'),
                  CHECK (fname LIKE '%[^a-zA-Z]%'),
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
                   CHECK (author LIKE '%[^a-zA-Z,.]%'),
                   PRIMARY KEY (storyID));

CREATE TABLE CLASS_TEACHER(classID CHAR(16) NOT NULL,
                           teacherID VARCHAR(255) NOT NULL,
                           CHECK (classID LIKE '%[0-9]%'),
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
                               assignmentNum TINYINT(255) NOT NULL,
                               classID CHAR(16) NOT NULL,
                               completionStatus VARCHAR(255) NOT NULL,
                               CHECK (completionStatus in 
                                       ('Started', 'Completed', 
                                       'Not Started')),
                               PRIMARY KEY (studentID, assignmentNum, classID),
                               FOREIGN KEY (AssignmentNum, classID) REFERENCES
                                            ASSIGNMENT(AssignmentNum, classID),
                               FOREIGN KEY (studentID) REFERENCES STUDENT(studentID));

