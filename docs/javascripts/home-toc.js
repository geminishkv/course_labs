(function () {
  function applyHomeState() {
    document.body.classList.toggle('page--home', !!document.querySelector('.hero-section'));
  }

  document.addEventListener('DOMContentLoaded', function () {
    applyHomeState();

    // MkDocs Material instant navigation replaces .md-content__inner children on page switch
    var inner = document.querySelector('.md-content__inner');
    if (inner) {
      new MutationObserver(applyHomeState).observe(inner, { childList: true });
    }
  });
})();
