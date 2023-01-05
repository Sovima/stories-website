form = document.getElementById("login-form")
form.addEventListener("submit", async function(event) {
    event.preventDefault();
    email = document.getElementById("login-email").value;
    password = document.getElementById("login-password").value;
    document.getElementById("login-form").reset()
    const response = await fetch("/login", {
        method : "POST",
        headers: { 
            'Content-Type': 'application/json'
        }, 
        body: JSON.stringify({ email: email, 
                            password: password})
    })
    const status = await response.json()
    console.log(status)
    console.log(status['status'])
    if ( status['status'] == 'OK' ) {
        location.reload()
    }

})