(function () {
  "use strict";

  /* ── Fade-in on scroll ── */

  // Only the page heroes and the lab cards reveal; headings, tables and code
  // are text the reader came for and show up at once.
  var FADE_SELECTORS = [
    ".hero-section",
    ".lab-card",
  ].join(",");

  function initFadeIn() {
    var elements = document.querySelectorAll(FADE_SELECTORS);
    elements.forEach(function (el) {
      if (!el.classList.contains("fade-in")) {
        el.classList.add("fade-in");
      }
    });

    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("fade-in--visible");
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.1, rootMargin: "0px 0px -40px 0px" }
    );

    elements.forEach(function (el) { observer.observe(el); });
  }

  /* ── Live pipeline (home): one pulse along the track when it scrolls into view ── */

  function initTrack() {
    var track = document.querySelector("ol.track");
    if (!track || track.classList.contains("track--live")) return;
    var still = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    if (still || !("IntersectionObserver" in window)) {
      track.classList.add("track--live");
      return;
    }
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("track--live");
          observer.disconnect();
        }
      });
    }, { threshold: 0.15 });
    observer.observe(track);
  }

  /* ── Landmarks: Material leaves nested table-of-contents navs and the code
     block toolbars unnamed, so a screen reader lists a run of identical
     "navigation" regions. Name the nested navs after their section and turn
     the code toolbars into labelled groups (they hold copy/select buttons). ── */

  function nameLandmarks() {
    document.querySelectorAll("nav.md-nav").forEach(function (nav) {
      if (nav.hasAttribute("aria-label") || nav.hasAttribute("aria-labelledby")) return;
      var item = nav.parentElement;
      var link = item && item.querySelector(":scope > a, :scope > label, :scope > .md-nav__container > a");
      var text = link && link.textContent.trim();
      if (text) nav.setAttribute("aria-label", text);
    });
    document.querySelectorAll("nav.md-code__nav").forEach(function (nav) {
      if (nav.getAttribute("role") === "group") return;
      nav.setAttribute("role", "group");
      nav.setAttribute("aria-label", "Действия с кодом");
    });
  }

  function init() {
    initFadeIn();
    initTrack();
    nameLandmarks();
    // code toolbars are mounted by Material a moment after the page swaps in
    setTimeout(nameLandmarks, 400);
  }

  // The hero border rotation and glow pulse are CSS animations (layout.css,
  // hero-spin / hero-glow); nothing here runs per frame.

  if (typeof document$ !== "undefined") {
    document$.subscribe(init);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
