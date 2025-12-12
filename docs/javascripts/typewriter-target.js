document.addEventListener("DOMContentLoaded", function () {
  const text = "Sic Parvis Magna. Auxilio Divino. Stay tuned ;) The most interesting part is just ahead";
  const el = document.getElementById("typewriter-target");

  const typeSpeed = 100;
  const pauseEnd  = 1250;
  let i = 0;

  function type() {
    if (i < text.length) {
      el.textContent += text.charAt(i);
      i++;
      setTimeout(type, typeSpeed);
    } else {
      setTimeout(() => {
        el.textContent = "";
        i = 0;
        type();
      }, pauseEnd);
    }
  }

  type();
});