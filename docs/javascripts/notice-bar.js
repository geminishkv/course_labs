(function () {
  "use strict";

  var TS_KEY = "notice_ts";
  var RESHOW_MS = 45 * 60 * 1000; // 45 минут

  function shouldShow() {
    try {
      var ts = localStorage.getItem(TS_KEY);
      if (!ts) return true;
      return Date.now() - Number(ts) > RESHOW_MS;
    } catch (_) { return true; }
  }

  function createNoticeBar() {
    if (!shouldShow()) return;

    var bar = document.createElement("div");
    bar.className = "notice-bar";
    bar.setAttribute("role", "region");
    bar.setAttribute("aria-label", "Уведомление");

    bar.innerHTML =
      '<div class="notice-bar__inner">' +
        '<div class="notice-bar__body">' +
          '<p class="notice-bar__title">Уведомление</p>' +
          '<div class="notice-bar__text">' +
            "<p>Вся информация в материалах данного курса, включая любые текстовые и графические произведения, рассматривается исключительно в ознакомительных целях.</p>" +
            "<p>Любое использование представленной информации на практике без получения предварительного согласования подпадает под действие действующего законодательства РФ.</p>" +
            "<p>Автор не несет ответственности за любой возможный вред, причиненный предоставляемыми материалами.</p>" +
            "<p>Все материалы носят ознакомительный характер в целях обучения прикладной безопасности приложений.</p>" +
          "</div>" +
          '<div class="notice-bar__disclaimer">Instagram* — продукт компании Meta Platforms Inc., деятельность которой запрещена на территории РФ как экстремистская (решение Тверского районного суда г. Москвы от 21.03.2022). LinkedIn заблокирован на территории РФ за нарушение ФЗ-152 «О персональных данных».</div>' +
        "</div>" +
        '<button class="notice-bar__close">Понятно</button>' +
      "</div>";

    document.body.appendChild(bar);

    bar.querySelector(".notice-bar__close").addEventListener("click", function () {
      bar.classList.remove("notice-bar--visible");
      try {
        localStorage.setItem(TS_KEY, String(Date.now()));
      } catch (_) {}
    });

    setTimeout(function () {
      bar.classList.add("notice-bar--visible");
    }, 600);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", createNoticeBar);
  } else {
    createNoticeBar();
  }
})();
