document.addEventListener("DOMContentLoaded", function () {
  var topic = document.querySelector(".md-header__title .md-header__topic");

  if (topic) {
    topic.textContent = "";

    var link = document.createElement("a");
    link.href = "https://geminishkv.tech/";
    link.target = "_blank";
    link.rel = "noopener noreferrer";
    link.textContent = "© AppSecTA";

    topic.appendChild(link);
  }
});