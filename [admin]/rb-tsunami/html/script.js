window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === "show") {
        document.getElementById("tsunami-warning").style.display = "block";
    } else if (data.action === "hide") {
        document.getElementById("tsunami-warning").style.display = "none";
    } else if (data.action === "update") {
        document.getElementById("countdown").textContent = data.time;
    }
});