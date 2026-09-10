(function () {
  "use strict";

  var OWNER = "geminishkv";
  var REPO = "course_labs";
  var CACHE_KEY = "gh-repo-stats";
  var CACHE_TTL = 3600000;

  var icons = {
    tag: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M1 7.775V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 0 1 0 2.474l-5.026 5.026a1.75 1.75 0 0 1-2.474 0l-6.25-6.25A1.752 1.752 0 0 1 1 7.775Zm1.5 0c0 .066.026.13.073.177l6.25 6.25a.25.25 0 0 0 .354 0l5.025-5.025a.25.25 0 0 0 0-.354l-6.25-6.25a.25.25 0 0 0-.177-.073H2.75a.25.25 0 0 0-.25.25ZM6 5a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"/></svg>',
    star: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.751.751 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z"/></svg>',
    fork: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M5 5.372v.878c0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75v-.878a2.25 2.25 0 1 1 1.5 0v.878a2.25 2.25 0 0 1-2.25 2.25h-1.5v2.128a2.251 2.251 0 1 1-1.5 0V8.5h-1.5A2.25 2.25 0 0 1 3.5 6.25v-.878a2.25 2.25 0 1 1 1.5 0ZM5 3.25a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Zm6.75.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm-3 8.75a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"/></svg>'
  };

  /* ── Header: glass effect once the page is scrolled (see header.css) ── */

  var header = document.querySelector(".md-header");

  function updateGlass() {
    if (header) header.classList.toggle("md-header--glass", window.scrollY > 10);
  }
  window.addEventListener("scroll", updateGlass, { passive: true });

  /* ── Repo stats: release, stars, forks ── */

  function fact(icon, value) {
    var li = document.createElement("li");
    li.className = "md-source__fact";
    li.innerHTML = icon + " "; // static SVG markup only
    li.appendChild(document.createTextNode(String(value))); // API data as text, never as HTML
    return li;
  }

  function renderOne(source, stats) {
    var facts = source.querySelector(".md-source__facts");
    if (!facts) {
      facts = document.createElement("ul");
      facts.className = "md-source__facts";
      source.appendChild(facts);
    }
    facts.innerHTML = "";
    if (stats.release) facts.appendChild(fact(icons.tag, stats.release));
    facts.appendChild(fact(icons.star, stats.stars));
    facts.appendChild(fact(icons.fork, stats.forks));
  }

  function renderStats(stats) {
    document.querySelectorAll(".md-source__repository").forEach(function (source) {
      renderOne(source, stats);
    });
  }

  function readCache() {
    try {
      var cached = JSON.parse(localStorage.getItem(CACHE_KEY));
      if (cached && Date.now() - cached.ts < CACHE_TTL) return cached;
    } catch (_) {}
    return null;
  }

  function writeCache(stats) {
    try {
      localStorage.setItem(CACHE_KEY, JSON.stringify({
        stars: stats.stars, forks: stats.forks, release: stats.release, ts: Date.now()
      }));
    } catch (_) {}
  }

  var pending = null;

  function fetchStats() {
    if (pending) return pending;
    var apiBase = "https://api.github.com/repos/" + OWNER + "/" + REPO;
    pending = Promise.all([
      fetch(apiBase).then(function (r) { return r.ok ? r.json() : null; }),
      fetch(apiBase + "/releases/latest")
        .then(function (r) { return r.ok ? r.json() : null; })
        .catch(function () { return null; })
    ]).then(function (results) {
      var data = results[0];
      if (!data) return null; // rate limit or network error: never cache zeros
      var stats = {
        stars: data.stargazers_count || 0,
        forks: data.forks_count || 0,
        release: results[1] ? results[1].tag_name : ""
      };
      writeCache(stats);
      return stats;
    }).catch(function () {
      return null;
    }).then(function (stats) {
      pending = null; // allow a retry on the next navigation
      return stats;
    });
    return pending;
  }

  function init() {
    updateGlass();
    var cached = readCache();
    if (cached) {
      renderStats(cached);
      return;
    }
    fetchStats().then(function (stats) {
      if (stats) renderStats(stats);
    });
  }

  // Material instant navigation swaps the sidebar (and its repo block) without a
  // page load: document$ emits on every navigation, DOMContentLoaded only once.
  if (typeof document$ !== "undefined") {
    document$.subscribe(init);
  } else if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
