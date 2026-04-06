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

  if (typeof document$ !== "undefined") {
    document$.subscribe(initFadeIn);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initFadeIn);
  } else {
    initFadeIn();
  }

  /* ── Hero border rotation + glow pulsation ── */

  var angle = 0;
  var start = performance.now();

  function lerp(a, b, t) { return a + (b - a) * t; }

  function tick(now) {
    angle = (angle + 0.5) % 360;

    var t = ((now - start) % 1000) / 1000;
    var mix = 0.5 - 0.5 * Math.cos(t * 2 * Math.PI);

    var r1 = lerp(213, 249, mix);
    var g1 = lerp(26, 179, mix);
    var b1 = lerp(26, 97, mix);
    var spread1 = lerp(12, 16, mix);
    var spread2 = lerp(30, 40, mix);
    var alpha1 = lerp(0.35, 0.4, mix);
    var alpha2 = lerp(0.1, 0.12, mix);

    var c = Math.round(r1) + "," + Math.round(g1) + "," + Math.round(b1);
    var shadow =
      "0 0 " + spread1 + "px rgba(" + c + "," + alpha1.toFixed(2) + "), " +
      "0 0 " + spread2 + "px rgba(" + c + "," + alpha2.toFixed(2) + ")";

    var heroes = document.querySelectorAll(".hero-section, .lab-hero");
    for (var i = 0; i < heroes.length; i++) {
      heroes[i].style.setProperty("--hero-angle", angle + "deg");
      heroes[i].style.boxShadow = shadow;
    }
    requestAnimationFrame(tick);
  }

  if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    requestAnimationFrame(tick);
  }
})();
