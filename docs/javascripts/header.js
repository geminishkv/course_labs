(function () {
  "use strict";

  /* Header: glass effect once the page is scrolled (see header.css).
     Repo stats in the drawer are rendered by Material's own `source` component. */

  var header = document.querySelector(".md-header");

  function updateGlass() {
    if (header) header.classList.toggle("md-header--glass", window.scrollY > 10);
  }

  window.addEventListener("scroll", updateGlass, { passive: true });
  updateGlass();
})();
