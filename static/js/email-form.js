form = document.getElementById("contact-form")
form.addEventListener("submit", function(event) {
    event.preventDefault();
    firstname = document.getElementById("firstname").value;
    lastname = document.getElementById("lastname").value;
    email = document.getElementById("email").value;
    message = document.getElementById("message").value;
    document.getElementById("contact-form").reset()
    console.log("This is the message: " + message)
    fetch("/submit-form", {
        method : "POST",
        headers: { 
            'Content-Type': 'application/json'
        }, 
        body: JSON.stringify({ email: email, 
                            firstname: firstname, 
                            lastname: lastname, 
                            message: message })
    })

})
