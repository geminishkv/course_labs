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

  // Логотип в хедере → ссылка на geminishkv.tech
  var logo = document.querySelector(".md-header .md-header__button.md-logo");
  if (logo) {
    logo.href = "https://geminishkv.tech/";
    logo.target = "_blank";
    logo.rel = "noopener noreferrer";
  }

});
