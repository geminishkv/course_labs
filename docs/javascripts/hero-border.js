(function () {
  "use strict";

  var angle = 0;
  var start = performance.now();

  function lerp(a, b, t) { return a + (b - a) * t; }

  function tick(now) {
    angle = (angle + 0.5) % 360;

    // Sine wave 0→1→0 over 3s
    var t = ((now - start) % 3000) / 3000;
    var mix = 0.5 - 0.5 * Math.cos(t * 2 * Math.PI);

    var r1 = lerp(213, 249, mix);
    var g1 = lerp(26, 179, mix);
    var b1 = lerp(26, 97, mix);
    var spread1 = lerp(12, 18, mix);
    var spread2 = lerp(30, 45, mix);
    var alpha1 = lerp(0.35, 0.5, mix);
    var alpha2 = lerp(0.1, 0.2, mix);

    var shadow =
      "0 0 " + spread1 + "px rgba(" + Math.round(r1) + "," + Math.round(g1) + "," + Math.round(b1) + "," + alpha1.toFixed(2) + "), " +
      "0 0 " + spread2 + "px rgba(" + Math.round(r1) + "," + Math.round(g1) + "," + Math.round(b1) + "," + alpha2.toFixed(2) + ")";

    var heroes = document.querySelectorAll(".hero-section");
    for (var i = 0; i < heroes.length; i++) {
      heroes[i].style.setProperty("--hero-angle", angle + "deg");
      heroes[i].style.boxShadow = shadow;
    }
    requestAnimationFrame(tick);
  }

  requestAnimationFrame(tick);
})();
