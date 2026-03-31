(function () {
  function applyHomeState() {
    document.body.classList.toggle('page--home', !!document.querySelector('.hero-section'));
  }

  document.addEventListener('DOMContentLoaded', function () {
    applyHomeState();

    // <title> is reliably replaced on every instant navigation in MkDocs Material.
    // Observing it as a childList change on document.head catches all page switches.
    new MutationObserver(function () {
      // Defer one tick so the new page content is already in the DOM.
      requestAnimationFrame(applyHomeState);
    }).observe(document.head, { childList: true });
  });
})();
