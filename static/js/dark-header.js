document.addEventListener("DOMContentLoaded", function() {
	document.querySelector("#light-dark-switch").onclick = function () {
        if (document.querySelector("#light-dark-switch").classList.contains("light")) {
            document.querySelector("#header-style").href = "/static/css/dark-header.css"
        } else {
            document.querySelector("#header-style").href = "/static/css/header.css"
        }
        document.querySelector("#light-dark-switch").classList.toggle("light")
	}
})
