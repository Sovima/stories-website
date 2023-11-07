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
                   CHECK (author REGEXP '[A-Za-z,.\s]+$'),
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

/*
Populate user table
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
Populate teacher table
*/

INSERT INTO TEACHER VALUES ('1', 'user1@email.test');
INSERT INTO TEACHER VALUES ('2', 'user2@email.test');
INSERT INTO TEACHER VALUES ('3', 'user3@email.test');
INSERT INTO TEACHER VALUES ('4', 'user4@email.test');
INSERT INTO TEACHER VALUES ('5', 'user5@email.test');


/*
Populate student table
*/

INSERT INTO STUDENT VALUES ('1', 'user6@email.test');
INSERT INTO STUDENT VALUES ('2', 'user7@email.test');
INSERT INTO STUDENT VALUES ('3', 'user8@email.test');
INSERT INTO STUDENT VALUES ('4', 'user9@email.test');
INSERT INTO STUDENT VALUES ('5', 'user12@email.test');


/*
Populate story table
*/

INSERT INTO STORY(storyID, storyName, textEnglish, textFrench) VALUES ('1', 'The terminator', '"The Terminator" (1984) is a sci-fi thriller directed by James Cameron. In a dystopian future, sentient machines led by Skynet wage war against humanity. To ensure their survival, they send a cyborg assassin, the Terminator (Arnold Schwarzenegger), back in time to kill Sarah Connor (Linda Hamilton), the mother of future resistance leader John Connor. However, resistance fighters also send a soldier, Kyle Reese (Michael Biehn), to protect Sarah. The film unfolds as a high-stakes chase, with the Terminator relentlessly pursuing Sarah while Reese tries to thwart it. This iconic film blends action, suspense, and a gripping battle against unstoppable technology.','"Terminator" (1984) est un thriller de science-fiction réalisé par James Cameron. Dans un futur dystopique, des machines conscientes dirigées par Skynet font la guerre à l''humanité. Pour assurer leur survie, elles envoient un assassin cyborg, le Terminator (Arnold Schwarzenegger), dans le passé pour tuer Sarah Connor (Linda Hamilton), la mère du futur chef de la résistance, John Connor. Cependant, des combattants de la résistance envoient également un soldat, Kyle Reese (Michael Biehn), pour protéger Sarah. Le film se déroule comme une poursuite à haut risque, avec le Terminator poursuivant implacablement Sarah tandis que Reese essaie de l''arrêter. Ce film emblématique mêle action, suspense et une lutte palpitante contre une technologie inarrêtable.');


INSERT INTO STORY VALUES ('2', 'CHAT GPT', 'Bee Movie', 'In "Bee Movie" (2007), an animated comedy, Barry B. Benson (voiced by Jerry Seinfeld), a disillusioned honeybee, embarks on an adventure beyond the hive. He forms an unusual bond with Vanessa Bloome (Renee Zellweger), a human florist, and discovers the exploitation of bees in the honey industry. Barry takes the legal route, suing humans for honey theft. The trial outcome, demanding bees to cease honey production, leads to global ecological chaos. Barry and the bees must restore the balance between nature and mankind. This quirky film mixes humor, environmental themes, and a message about the consequences of meddling with the natural world.','Dans "Bee Movie" (2007), une comédie animée, Barry B. Benson (exprimé par Jerry Seinfeld), une abeille ouvrière désillusionnée, se lance dans une aventure au-delà de la ruche. Il développe un lien inhabituel avec Vanessa Bloome (Renee Zellweger), une fleuriste humaine, et découvre l''exploitation des abeilles dans l''industrie du miel. Barry choisit la voie légale et poursuit les humains pour vol de miel. Le verdict du procès, exigeant que les abeilles cessent la production de miel, entraîne le chaos écologique mondial. Barry et les abeilles doivent rétablir l''équilibre entre la nature et l''humanité. Ce film décalé mêle humour, thèmes environnementaux et un message sur les conséquences de l''ingérence dans le monde naturel.');


INSERT INTO STORY VALUES ('3', 'Mr. CHAT, GPT', 'The terminator', '"The Terminator" (1984) is a sci-fi thriller directed by James Cameron. In a dystopian future, sentient machines led by Skynet wage war against humanity. To ensure their survival, they send a cyborg assassin, the Terminator (Arnold Schwarzenegger), back in time to kill Sarah Connor (Linda Hamilton), the mother of future resistance leader John Connor. However, resistance fighters also send a soldier, Kyle Reese (Michael Biehn), to protect Sarah. The film unfolds as a high-stakes chase, with the Terminator relentlessly pursuing Sarah while Reese tries to thwart it. This iconic film blends action, suspense, and a gripping battle against unstoppable technology.','
"Terminator" (1984) est un thriller de science-fiction réalisé par James Cameron. Dans un futur dystopique, des machines conscientes dirigées par Skynet font la guerre à l''humanité. Pour assurer leur survie, elles envoient un assassin cyborg, le Terminator (Arnold Schwarzenegger), dans le passé pour tuer Sarah Connor (Linda Hamilton), la mère du futur chef de la résistance, John Connor. Cependant, des combattants de la résistance envoient également un soldat, Kyle Reese (Michael Biehn), pour protéger Sarah. Le film se déroule comme une poursuite à haut risque, avec le Terminator poursuivant implacablement Sarah tandis que Reese essaie de l''arrêter. Ce film emblématique mêle action, suspense et une lutte palpitante contre une technologie inarrêtable.');


INSERT INTO STORY VALUES ('4', 'Mr. CHAT, GPT', 'Grey''s Anatomy', '"Grey''s Anatomy" is a long-running medical drama series that follows the lives of surgical interns, residents, and attending physicians at Grey Sloan Memorial Hospital. The show, created by Shonda Rhimes, delves into their professional and personal challenges, relationships, and the complex cases they encounter. Centered around Dr. Meredith Grey (Ellen Pompeo), the series explores the triumphs and tragedies in the high-stress world of healthcare. Themes of love, loss, ambition, and ethics are interwoven as the characters navigate their careers. "Grey''s Anatomy" has become known for its compelling characters and emotional storytelling while addressing medical and ethical dilemmas.','
""Grey''s Anatomy" est une série médicale à longue durée qui suit la vie des internes en chirurgie, des résidents et des médecins en exercice à l''hôpital Grey Sloan Memorial. Créée par Shonda Rhimes, la série explore leurs défis professionnels et personnels, leurs relations et les cas médicaux complexes auxquels ils sont confrontés. Centrée autour du Dr. Meredith Grey (Ellen Pompeo), la série explore les triomphes et les tragédies dans le monde stressant des soins de santé. Des thèmes tels que l''amour, la perte, l''ambition et l''éthique sont entrelacés alors que les personnages naviguent dans leur carrière. "Grey''s Anatomy" est connue pour ses personnages captivants et ses récits émotionnels tout en abordant des dilemmes médicaux et éthiques.');




INSERT INTO STORY VALUES ('5', 'GPT. CHAT', 'Little Miss Sunshine', '"Little Miss Sunshine" (2006) is a heartwarming comedy-drama. The dysfunctional Hoover family embarks on a road trip to California in their beat-up VW bus to support their young daughter, Olive (Abigail Breslin), in the "Little Miss Sunshine" beauty pageant. Each family member is grappling with personal crises, from a failed self-help guru (Greg Kinnear) to a nihilistic teen (Paul Dano). Their journey is filled with chaos, bonding, and unexpected revelations as they learn the true meaning of family. The film explores themes of acceptance, individuality, and the pursuit of happiness, all wrapped in a charming, quirky, and touching story.','"Little Miss Sunshine" (2006) est une comédie dramatique chaleureuse. La dysfonctionnelle famille Hoover entreprend un voyage en voiture vers la Californie dans leur minibus VW en mauvais état pour soutenir leur jeune fille, Olive (Abigail Breslin), au concours de beauté "Little Miss Sunshine". Chaque membre de la famille fait face à des crises personnelles, du gourou du développement personnel en échec (Greg Kinnear) à l''adolescent nihiliste (Paul Dano). Leur voyage est rempli de chaos, de rapprochements et de révélations inattendues alors qu''ils découvrent la vraie signification de la famille. Le film explore les thèmes de l''acceptation, de l''individualité et de la quête du bonheur, le tout enveloppé dans une histoire charmante, excentrique et émouvante.');







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


