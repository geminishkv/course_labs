(function () {
  "use strict";

  var PHRASES = [
    "Sic Parvis Magna",
    "Auxilio Divino",
    "Stay tuned ;)"
  ];
  var TYPE_SPEED = 100;
  var DELETE_SPEED = 60;
  var PAUSE_END = 1500;
  var PAUSE_START = 300;

  var runId = 0;
  var timer = null;

  function start() {
    runId++; // invalidates the loop that belonged to the previous page
    clearTimeout(timer);

    var el = document.getElementById("typewriter-target");
    if (!el) return;

    var id = runId;
    var phraseIndex = 0;
    var charIndex = 0;
    var deleting = false;

    function tick() {
      if (id !== runId) return; // a newer page took over
      var current = PHRASES[phraseIndex];
      var delay;

      if (!deleting) {
        charIndex++;
        el.textContent = current.slice(0, charIndex);
        if (charIndex === current.length) {
          deleting = true;
          delay = PAUSE_END;
        } else {
          delay = TYPE_SPEED;
        }
      } else {
        charIndex--;
        el.textContent = current.slice(0, charIndex);
        if (charIndex === 0) {
          deleting = false;
          phraseIndex = (phraseIndex + 1) % PHRASES.length;
          delay = PAUSE_START;
        } else {
          delay = DELETE_SPEED;
        }
      }
      timer = setTimeout(tick, delay);
    }

    tick();
  }

  // Material instant navigation re-creates the hero without a page load:
  // document$ emits on every navigation, DOMContentLoaded only once.
  if (typeof document$ !== "undefined") {
    document$.subscribe(start);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start);
  } else {
    start();
  }
})();
