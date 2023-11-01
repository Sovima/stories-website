form = document.getElementById("signup-form")
form.addEventListener("submit", async function(event) {
    console.log("sumbitting the signup form");
    event.preventDefault();
    email = document.getElementById("signup-email").value;
    password = document.getElementById("signup-password").value;
    fistName = document.getElementById("firstName").value;
    lastName = document.getElementById("lastName").value;
    userTypes = document.getElementsByName("userType");
    userType = "Other";
    for (i = 0; i < userTypes.length; i++) {
        if (userTypes[i].checked)
                userType = userTypes[i].value;
    }
    document.getElementById("signup-form").reset()
    const response = await fetch("/signed-up", {
        method : "POST",
        headers: { 
            'Content-Type': 'application/json'
        }, 
        body: JSON.stringify({ email: email, 
                            password: password,
                            fname: firstName,
                            lname: lastName,
                            userType: userType})
    })
    const status = await response.json()
    console.log(userType);
    console.log(status);
    console.log(status['status'])
    if ( status['status'] == 'OK' ) {
        location.reload()
    }

})
