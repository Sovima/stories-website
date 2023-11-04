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
                            password: password},)
    })
    const status = await response.json()
    console.log(status)
    console.log(status['status'])
    if ( status['status'] == 'OK' ) {
        location.reload()
    }

})



function showLogin() {
    loginButton = document.getElementById("login-window")
    loginButton.classList.add("showing-login")
}


function removeLogin() {
    loginButton = document.getElementById("login-window")
    loginButton.classList.remove("showing-login")
    switchToLogin()
}

function switchToSignup() {
    loginFields = document.getElementById("login-form-full")
    loginFields.classList.add("hide")
    signupFields = document.getElementById("signup-form-full")
    signupFields.classList.remove("hide")
}

function switchToLogin() {
    loginFields = document.getElementById("signup-form-full")
    loginFields.classList.add("hide")
    signupFields = document.getElementById("login-form-full")
    signupFields.classList.remove("hide")
}
