(function () {
  "use strict";

  /* ── Fade-in on scroll ── */

  var FADE_SELECTORS = [
    ".md-typeset h2",
    ".md-typeset h3",
    ".hero-section",
    ".lab-card",
    ".admonition",
    ".md-typeset table",
    ".highlight",
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

  function init() {
    initFadeIn();
    initTrack();
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
