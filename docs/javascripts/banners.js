(function () {
  "use strict";

  /* Analytics consent: Yandex.Metrika loads only after "Принять"; the choice is
     kept for half a year. Domain-locked so local and preview builds never track.
     The legal notice is no longer a bar over the content: its text lives in
     privacy.md#notice and the footer links to it. */
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

  /* ── Consent card (bottom-right) ── */

  function showConsent(force) {
    if (!force && consent() !== null) return;

    // one card per page: asking again after "Изменить выбор" reopens the same card
    var existing = document.getElementById("ata-consent");
    if (existing) { existing.hidden = false; return; }

    var card = document.createElement("div");
    card.className = "ata-consent";
    card.id = "ata-consent";
    card.setAttribute("role", "dialog");
    card.setAttribute("aria-labelledby", "ata-consent-title");

    card.innerHTML =
      '<p class="ata-consent__title" id="ata-consent-title">Файлы cookie</p>' +
      '<p class="ata-consent__text">' +
        "Сайт использует cookie и Яндекс.Метрику для статистики посещений. " +
        "Метрика включается только после «Принять». Подробнее в " +
        '<a href="/privacy/">политике конфиденциальности</a>.' +
      "</p>" +
      '<div class="ata-consent__actions">' +
        '<button type="button" class="ata-consent__btn ata-consent__btn--accept">Принять</button>' +
        '<button type="button" class="ata-consent__btn ata-consent__btn--decline">Отклонить</button>' +
      "</div>";

    document.body.appendChild(card);

    card.querySelector(".ata-consent__btn--accept").addEventListener("click", function () {
      setConsent("accepted"); card.hidden = true; loadMetrika();
    });
    card.querySelector(".ata-consent__btn--decline").addEventListener("click", function () {
      setConsent("declined"); card.hidden = true;
    });
  }

  // privacy page: <a href="#" data-consent-reset>…</a> forgets the choice and asks again
  document.addEventListener("click", function (e) {
    var reset = e.target.closest && e.target.closest("[data-consent-reset]");
    if (!reset) return;
    e.preventDefault();
    try { localStorage.removeItem(CONSENT_KEY); } catch (_) {}
    showConsent(true);
  });

  /* ── Init ── */

  function init() {
    // the old notice bar kept its dismissal time here; nothing reads it any more
    try { localStorage.removeItem("notice_ts"); } catch (_) {}
    if (consent() === "accepted") loadMetrika();
    setTimeout(function () { showConsent(false); }, 1200);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
