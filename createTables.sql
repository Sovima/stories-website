/*
Database and table creation, with necessary constraints
*/
CREATE DATABASE stories;
USE stories;
CREATE TABLE USER(email VARCHAR(255),
                  lname VARCHAR(40),
                  fname VARCHAR(40),
                  password VARCHAR(255),
                  CHECK (email LIKE '%_@__%.__%'),
                  CHECK (lname LIKE '%[^a-zA-Z]%'),
                  CHECK (fname LIKE '%[^a-zA-Z]%'),
                  PRIMARY KEY (email));

CREATE TABLE TEACHER(teacherID VARCHAR(255),
                     email VARCHAR(255),
                     PRIMARY KEY (teacherID),
                     FOREIGN KEY (email) REFERENCES USER(email));

CREATE TABLE STUDENT(studentID VARCHAR(255),
                     email VARCHAR(255),
                     PRIMARY KEY (studentID),
                     FOREIGN KEY (email) REFERENCES USER(email));

CREATE TABLE STORY(storyID VARCHAR(255),
                   author VARCHAR(100),
                   storyName VARCHAR(255),
                   textEnglish TEXT,
                   textFrench TEXT,
                   CHECK (fname LIKE '%[^a-zA-Z,.]%'),
                   PRIMARY KEY (storyID));

CREATE TABLE CLASS_TEACHER(classID CHAR(16),
                           teacherID VARCHAR(255),
                           CHECK (fname LIKE '%[0-9]%'),
                           PRIMARY KEY (classID),
                           FOREIGN KEY (teacherID) REFERENCES TEACHER(teacherID));

CREATE TABLE ASSIGNMENT(AssignmentNum TINYINT,
                        classID CHAR(16),
                        storyID VARCHAR(255),
                        deadlineDate DATE,
                        deadlineTime TIME,
                        PRIMARY KEY (AssignmentNum, classID),
                        FOREIGN KEY (classID) REFERENCES CLASS_TEACHER(classID),
                        FOREIGN KEY (storyID) REFERENCES STORY(storyID));

CREATE TABLE CLASSES(classID CHAR(16),
                     studentID VARCHAR(255),
                     PRIMARY KEY (classID, studentID),
                     FOREIGN KEY (classID) REFERENCES CLASS_TEACHER(classID),
                     FOREIGN KEY (studentID) REFERENCES STUDENT(studentID));

CREATE TABLE ASSIGNMENT_STATUS(studentID VARCHAR(255), 
                               assignmentNum TINYINT(255),
                               classID CHAR(16),
                               completionStatus VARCHAR(255),
                               CHECK (completionStatus in 
                                       ('Started', 'Completed', 
                                       'Not Started')),
                               PRIMARY KEY (studentID, assignmentNum, classID),
                               FOREIGN KEY (AssignmentNum, classID) REFERENCES
                                            ASSIGNMENT(AssignmentNum, classID),
                               FOREIGN KEY (studentID) REFERENCES STUDENT(studentID));

