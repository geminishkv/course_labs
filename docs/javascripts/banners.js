(function () {
  "use strict";

  var RESHOW_MS = 45 * 60 * 1000; // 45 минут

  function shouldShow(key) {
    try {
      var ts = localStorage.getItem(key);
      if (!ts) return true;
      return Date.now() - Number(ts) > RESHOW_MS;
    } catch (_) { return true; }
  }

  function dismiss(key, el) {
    if (el) el.hidden = true;
    try { localStorage.setItem(key, String(Date.now())); } catch (_) {}
  }

  /* ── Notice bar (bottom) ── */

  function createNoticeBar() {
    if (!shouldShow("notice_ts")) return;

    var bar = document.createElement("div");
    bar.className = "ata-legal";
    bar.setAttribute("role", "region");
    bar.setAttribute("aria-label", "Уведомление");

    bar.innerHTML =
      '<div class="ata-legal__inner">' +
        '<div class="ata-legal__body">' +
          '<p class="ata-legal__title">Уведомление</p>' +
          '<div class="ata-legal__text">' +
            "<p>Вся информация в материалах данного курса, включая любые текстовые и графические произведения, рассматривается исключительно в ознакомительных целях.</p>" +
            "<p>Любое использование представленной информации на практике без получения предварительного согласования подпадает под действие действующего законодательства РФ.</p>" +
            "<p>Автор не несет ответственности за любой возможный вред, причиненный предоставляемыми материалами.</p>" +
            "<p>Все материалы носят ознакомительный характер в целях обучения прикладной безопасности приложений.</p>" +
          "</div>" +
          '<div class="ata-legal__disclaimer">Instagram* — продукт компании Meta Platforms Inc., деятельность которой запрещена на территории РФ как экстремистская (решение Тверского районного суда г. Москвы от 21.03.2022). LinkedIn заблокирован на территории РФ за нарушение ФЗ-152 «О персональных данных».</div>' +
        "</div>" +
        '<button class="ata-legal__close">Понятно</button>' +
      "</div>";

    document.body.appendChild(bar);

    // The cookie banner stacks above the bar: publish the bar height as a CSS variable.
    function publishHeight() {
      var h = bar.classList.contains("ata-legal--visible") ? bar.offsetHeight : 0;
      document.documentElement.style.setProperty("--ata-legal-h", h + "px");
    }
    window.addEventListener("resize", publishHeight);

    bar.querySelector(".ata-legal__close").addEventListener("click", function () {
      bar.classList.remove("ata-legal--visible");
      publishHeight();
      window.removeEventListener("resize", publishHeight);
      dismiss("notice_ts", null);
    });

    setTimeout(function () {
      bar.classList.add("ata-legal--visible");
      publishHeight();
    }, 600);
  }

  /* ── Cookie banner (bottom-right, above the notice bar) ── */

  function createCookieBanner() {
    if (!shouldShow("cookie_ts")) return;

    var banner = document.createElement("div");
    banner.className = "ata-consent";
    banner.id = "ata-consent";
    banner.setAttribute("role", "dialog");
    banner.setAttribute("aria-label", "Файлы cookie");

    banner.innerHTML =
      '<div class="ata-consent__icon">' +
        '<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">' +
          '<circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5"/>' +
          '<circle cx="8" cy="10" r="1.5" fill="currentColor"/>' +
          '<circle cx="15" cy="8" r="1" fill="currentColor"/>' +
          '<circle cx="13" cy="14" r="1.5" fill="currentColor"/>' +
          '<circle cx="9" cy="15" r="1" fill="currentColor"/>' +
          '<circle cx="16" cy="13" r="0.8" fill="currentColor"/>' +
        "</svg>" +
      "</div>" +
      '<p class="ata-consent__title">Файлы cookie</p>' +
      '<p class="ata-consent__text">' +
        "Мы используем файлы cookie и сервисы аналитики для улучшения работы сайта. Продолжая использовать сайт, вы соглашаетесь с обработкой данных в соответствии с " +
        '<a href="/privacy/">Политикой конфиденциальности</a>.' +
      "</p>" +
      '<div class="ata-consent__actions">' +
        '<button class="ata-consent__btn ata-consent__btn--accept">Принять</button>' +
        '<button class="ata-consent__btn ata-consent__btn--decline">Отклонить</button>' +
      "</div>";

    document.body.appendChild(banner);

    function onDismiss() { dismiss("cookie_ts", banner); }
    banner.querySelector(".ata-consent__btn--accept").addEventListener("click", onDismiss);
    banner.querySelector(".ata-consent__btn--decline").addEventListener("click", onDismiss);
  }

  /* ── Init ── */

  function init() {
    createNoticeBar();
    setTimeout(createCookieBanner, 1800);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
