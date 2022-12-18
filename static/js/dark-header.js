document.addEventListener("DOMContentLoaded", function() {
	document.querySelector("#light-dark-switch").onclick = function () {
        document.querySelector("#body").classList.toggle("dark")
		let mode = "light"
		if (document.querySelector("#body").getAttribute("class") == "dark") {
			mode = "dark"
		}
		fetch("/change-mode", {
			method : "POST",
			headers: 
			{ 
				'Content-Type': 'application/json'
			}, 
			body: JSON.stringify({ mode: mode })
		})
	}

})
