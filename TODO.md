Some important links:
- Conversation with ChatGpt - https://chat.openai.com/chat/e9ddb476-30f1-4999-9c34-ffabd24d7323



A few things to do:
- [x] On the home page, image on the left, text on the right, and an unaligned yellow box in the background
- [x] Add a dark mode button
- [x] On the stories page, make cards with images and story titles
- [ ] Add login/signup/logout option
- [ ] On each story add a back to the top button 
- [x] Add a back (to the stories page) button
- [x] Highlight the card on hover
- [x] Contact us page with story suggestions, etc
- [ ] Profile with bookmarks
- [x] Watch https://www.youtube.com/watch?v=kUMe1FH4CHE&loop=0
- [ ] Add the french text - https://teteamodeler.ouest-france.fr/images/conte/pdf/le-chat-botte.pdf
- [x] Add link underline hover effect - https://www.youtube.com/watch?v=aswRKAjjWuE&loop=0
- [ ] Add encoding to the passwords (don't store the passwords as is)
- [ ] Test out various dark mode palletes
- [ ] Create a feature of adding new stories. The user will add 
- [ ] Put the story into a database. Each story is a list of the highlight to the highlight number. 

###### Friday March 24th:

First,
- [x] Hash the passwords

General idea for the database: 
- The text and the highlights are stored in a MongoDB database
- The text is just the full text
- The highlights is a list of highlight objects that are:
    - a list of start and end tuples that point to the start and end of the highlight

Hence, today I should 
- [ ] Create a page that takes in two texts, english and french
- [x] Install pymongo and import the MongoClient



Some other day:
- [ ] Add an entry to the databse (no routes)
- [ ] create a frontend to allow for addition of new stories


My CS348 project will be based on this website. Hence, the website might need somerestructuring. A few notes on the changes:
1. The users will have the option to be a teacher or a student
2. Teachers will have the option to assign a story to a class
3. If a user marked themselves as a student or a teacher they will have options to enroll in more classes after logging in (should be a separate window)
4. If a user marked themselves as a teacher, a class ID will be generated which can be later shared with students
5. When a student is enrolling, they must select a class that exists
6. When registering, a teachers and students must enroll in at least one class
7. Students will have the option to update the status of their Assignment



To-dos for the datatypes:
- [ ] Add a check to email to make sure it follows the rigth format (with )
- [ ] Set foreign keys using alter because there are some circular foreign keys
- [ ] Add a check to make sure fname and lname don't contain any special characters
- [ ] Class is a varchar of 16 but can only contain values 0-9