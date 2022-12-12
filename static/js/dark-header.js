document.addEventListener("DOMContentLoaded", function() {
	document.querySelector("#light-dark-switch").onclick = function () {
        document.querySelector("#body").classList.toggle("dark")
	}
})
