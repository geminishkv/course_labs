(function () {
  "use strict";

  var SELECTORS = [
    ".md-typeset h2",
    ".md-typeset h3",
    ".hero-section",
    ".lab-card",
    ".admonition",
    ".md-typeset table",
    ".highlight",
  ].join(",");

  function init() {
    var elements = document.querySelectorAll(SELECTORS);
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

  // Re-init on MkDocs instant navigation
  if (typeof document$ !== "undefined") {
    document$.subscribe(init);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
