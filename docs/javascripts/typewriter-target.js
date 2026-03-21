document.addEventListener("DOMContentLoaded", function () {
  const phrases = [
    "Sic Parvis Magna",
    "Auxilio Divino",
    "Stay tuned ;)",
  ];
  const el = document.getElementById("typewriter-target");
  if (!el) return;

  const typeSpeed   = 100;
  const deleteSpeed = 60;
  const pauseEnd    = 1500;
  const pauseStart  = 300;

  let phraseIndex = 0;
  let charIndex   = 0;
  let deleting    = false;

  function tick() {
    const current = phrases[phraseIndex];

    if (!deleting) {
      el.textContent = current.slice(0, charIndex + 1);
      charIndex++;
      if (charIndex === current.length) {
        deleting = true;
        setTimeout(tick, pauseEnd);
        return;
      }
      setTimeout(tick, typeSpeed);
    } else {
      el.textContent = current.slice(0, charIndex - 1);
      charIndex--;
      if (charIndex === 0) {
        deleting = false;
        phraseIndex = (phraseIndex + 1) % phrases.length;
        setTimeout(tick, pauseStart);
        return;
      }
      setTimeout(tick, deleteSpeed);
    }
  }

  tick();
});