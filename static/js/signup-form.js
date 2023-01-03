form = document.getElementById("signup-form")
form.addEventListener("submit", function(event) {
    event.preventDefault();
    email = document.getElementById("signup-email").value;
    password = document.getElementById("signup-password").value;
    document.getElementById("signup-form").reset()
    fetch("/signed-up", {
        method : "POST",
        headers: { 
            'Content-Type': 'application/json'
        }, 
        body: JSON.stringify({ email: email, 
                            password: password})
    })

})
