(function () {
  "use strict";

  var RESHOW_MS = 45 * 60 * 1000; // legal notice: shown again after 45 minutes

  /* Analytics consent: Yandex.Metrika loads only after "Принять"; the choice is
     kept for half a year. Domain-locked so local and preview builds never track. */
  var CONSENT_KEY = "ata_consent";
  var CONSENT_TTL = 180 * 24 * 60 * 60 * 1000;
  var METRIKA_ID = 108454150;
  var METRIKA_HOSTS = ["course.geminishkv.tech", "geminishkv.github.io"];

  function consent() {
    try {
      var v = JSON.parse(localStorage.getItem(CONSENT_KEY));
      if (v && v.value && Date.now() - Number(v.ts) < CONSENT_TTL) return v.value;
    } catch (_) {}
    return null;
  }

  function setConsent(value) {
    try { localStorage.setItem(CONSENT_KEY, JSON.stringify({ value: value, ts: Date.now() })); } catch (_) {}
  }

  function loadMetrika() {
    if (window.ym || METRIKA_HOSTS.indexOf(location.hostname) === -1) return;
    (function (m, e, t, r, i, k, a) {
      m[i] = m[i] || function () { (m[i].a = m[i].a || []).push(arguments); };
      m[i].l = 1 * new Date();
      k = e.createElement(t); a = e.getElementsByTagName(t)[0];
      k.async = 1; k.src = r; a.parentNode.insertBefore(k, a);
    })(window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");
    window.ym(METRIKA_ID, "init", {
      clickmap: true, trackLinks: true, accurateTrackBounce: true, webvisor: true, ecommerce: "dataLayer", triggerEvent: true
    });
    // instant navigation swaps pages without a load: report every later page view
    if (typeof document$ !== "undefined") {
      var first = true;
      document$.subscribe(function () {
        if (first) { first = false; return; }
        window.ym(METRIKA_ID, "hit", location.href, { title: document.title });
      });
    }
  }

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

  function createCookieBanner(force) {
    if (!force && consent() !== null) return;
    if (document.getElementById("cookie-banner")) return;

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

    banner.querySelector(".ata-consent__btn--accept").addEventListener("click", function () {
      setConsent("accepted"); banner.hidden = true; loadMetrika();
    });
    banner.querySelector(".ata-consent__btn--decline").addEventListener("click", function () {
      setConsent("declined"); banner.hidden = true;
    });
  }

  // privacy page: <a href="#" data-consent-reset>…</a> forgets the choice and asks again
  document.addEventListener("click", function (e) {
    var reset = e.target.closest && e.target.closest("[data-consent-reset]");
    if (!reset) return;
    e.preventDefault();
    try { localStorage.removeItem(CONSENT_KEY); } catch (_) {}
    createCookieBanner(true);
  });

  /* ── Init ── */

  function init() {
    if (consent() === "accepted") loadMetrika();
    createNoticeBar();
    setTimeout(function () { createCookieBanner(false); }, 1800);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
