(function () {
  "use strict";

  var SESSION_KEY = "notice_dismissed";

  function createNoticeBar() {
    try {
      if (sessionStorage.getItem(SESSION_KEY)) return;
    } catch (_) {
      return;
    }

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
        sessionStorage.setItem(SESSION_KEY, "1");
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
