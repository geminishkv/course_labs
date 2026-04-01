document.addEventListener("DOMContentLoaded", function () {

  // ── Header: © AppSecTA link ──
  var topic = document.querySelector(".md-header__title .md-header__topic");
  if (topic) {
    topic.textContent = "";
    var link = document.createElement("a");
    link.href = "https://geminishkv.tech/";
    link.target = "_blank";
    link.rel = "noopener noreferrer";
    link.textContent = "\u00a9 AppSecTA";
    topic.appendChild(link);
  }

  // ── Header: logo → geminishkv.tech ──
  var logo = document.querySelector(".md-header .md-header__button.md-logo");
  if (logo) {
    logo.href = "https://geminishkv.tech/";
    logo.target = "_blank";
    logo.rel = "noopener noreferrer";
  }

  // ── Repo stats: stars, forks, release ──
  var owner = "geminishkv";
  var repo = "course_labs";
  var cacheKey = "gh-repo-stats";
  var cacheTTL = 3600000;

  var icons = {
    tag: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M1 7.775V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 0 1 0 2.474l-5.026 5.026a1.75 1.75 0 0 1-2.474 0l-6.25-6.25A1.752 1.752 0 0 1 1 7.775Zm1.5 0c0 .066.026.13.073.177l6.25 6.25a.25.25 0 0 0 .354 0l5.025-5.025a.25.25 0 0 0 0-.354l-6.25-6.25a.25.25 0 0 0-.177-.073H2.75a.25.25 0 0 0-.25.25ZM6 5a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"/></svg>',
    star: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.751.751 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z"/></svg>',
    fork: '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="14" height="14" fill="currentColor"><path d="M5 5.372v.878c0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75v-.878a2.25 2.25 0 1 1 1.5 0v.878a2.25 2.25 0 0 1-2.25 2.25h-1.5v2.128a2.251 2.251 0 1 1-1.5 0V8.5h-1.5A2.25 2.25 0 0 1 3.5 6.25v-.878a2.25 2.25 0 1 1 1.5 0ZM5 3.25a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Zm6.75.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm-3 8.75a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"/></svg>'
  };

  function renderOne(source, stars, forks, release) {
    var facts = source.querySelector(".md-source__facts");
    if (!facts) {
      facts = document.createElement("ul");
      facts.className = "md-source__facts";
      source.appendChild(facts);
    }
    facts.innerHTML = "";
    if (release) {
      var li0 = document.createElement("li");
      li0.className = "md-source__fact";
      li0.innerHTML = icons.tag + " " + release;
      facts.appendChild(li0);
    }
    var li1 = document.createElement("li");
    li1.className = "md-source__fact";
    li1.innerHTML = icons.star + " " + stars;
    facts.appendChild(li1);
    var li2 = document.createElement("li");
    li2.className = "md-source__fact";
    li2.innerHTML = icons.fork + " " + forks;
    facts.appendChild(li2);
  }

  function renderStats(stars, forks, release) {
    document.querySelectorAll(".md-source__repository").forEach(function (source) {
      renderOne(source, stars, forks, release);
    });
  }

  var cached = null;
  try { cached = JSON.parse(localStorage.getItem(cacheKey)); } catch (_) {}

  if (cached && Date.now() - cached.ts < cacheTTL) {
    renderStats(cached.stars, cached.forks, cached.release);
    return;
  }

  var apiBase = "https://api.github.com/repos/" + owner + "/" + repo;
  Promise.all([
    fetch(apiBase).then(function (r) { return r.json(); }),
    fetch(apiBase + "/releases/latest").then(function (r) {
      return r.ok ? r.json() : null;
    }).catch(function () { return null; })
  ]).then(function (results) {
    var data = results[0];
    var rel = results[1];
    var stars = data.stargazers_count || 0;
    var forks = data.forks_count || 0;
    var release = rel ? rel.tag_name : "";
    try {
      localStorage.setItem(cacheKey, JSON.stringify({
        stars: stars, forks: forks, release: release, ts: Date.now()
      }));
    } catch (_) {}
    renderStats(stars, forks, release);
  }).catch(function () {});

});
