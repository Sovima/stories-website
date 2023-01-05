form = document.getElementById("signup-form")
form.addEventListener("submit", async function(event) {
    event.preventDefault();
    email = document.getElementById("signup-email").value;
    password = document.getElementById("signup-password").value;
    document.getElementById("signup-form").reset()
    const response = await fetch("/signed-up", {
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
