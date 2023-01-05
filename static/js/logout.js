function logout () {
    fetch("/logout", {
        method : "POST",
        headers: 
        { 
            'Content-Type': 'application/json'
        }, 
        body: null
    })
}