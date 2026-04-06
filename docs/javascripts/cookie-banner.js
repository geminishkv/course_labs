(function () {
  "use strict";

  var TS_KEY = "cookie_ts";
  var RESHOW_MS = 45 * 60 * 1000; // 45 минут

  function shouldShow() {
    try {
      var ts = localStorage.getItem(TS_KEY);
      if (!ts) return true;
      return Date.now() - Number(ts) > RESHOW_MS;
    } catch (_) {
      return true;
    }
  }

  function dismiss() {
    var el = document.getElementById("cookie-banner");
    if (el) el.hidden = true;
    try {
      localStorage.setItem(TS_KEY, String(Date.now()));
    } catch (_) {}
  }

  function createCookieBanner() {
    if (!shouldShow()) return;

    var banner = document.createElement("div");
    banner.className = "cookie-banner";
    banner.id = "cookie-banner";
    banner.setAttribute("role", "dialog");
    banner.setAttribute("aria-label", "Файлы cookie");

    banner.innerHTML =
      '<div class="cookie-banner__icon">' +
        '<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">' +
          '<circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5"/>' +
          '<circle cx="8" cy="10" r="1.5" fill="currentColor"/>' +
          '<circle cx="15" cy="8" r="1" fill="currentColor"/>' +
          '<circle cx="13" cy="14" r="1.5" fill="currentColor"/>' +
          '<circle cx="9" cy="15" r="1" fill="currentColor"/>' +
          '<circle cx="16" cy="13" r="0.8" fill="currentColor"/>' +
        "</svg>" +
      "</div>" +
      '<p class="cookie-banner__title">Файлы cookie</p>' +
      '<p class="cookie-banner__text">' +
        "Мы используем файлы cookie и сервисы аналитики для улучшения работы сайта. Продолжая использовать сайт, вы соглашаетесь с обработкой данных в соответствии с " +
        '<a href="privacy/">Политикой конфиденциальности</a>.' +
      "</p>" +
      '<div class="cookie-banner__actions">' +
        '<button class="cookie-banner__btn cookie-banner__btn--accept">Принять</button>' +
        '<button class="cookie-banner__btn cookie-banner__btn--decline">Отклонить</button>' +
      "</div>";

    document.body.appendChild(banner);

    banner.querySelector(".cookie-banner__btn--accept").addEventListener("click", dismiss);
    banner.querySelector(".cookie-banner__btn--decline").addEventListener("click", dismiss);
  }

  function init() {
    setTimeout(createCookieBanner, 1800);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
