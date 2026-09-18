(function () {
  "use strict";

  /* Self-hosted Mermaid, loaded on demand.
     Material renders diagrams through the global `mermaid` and fetches it from
     unpkg only when that global is missing; the site CSP blocks unpkg. This stub
     is the global: it keeps Material's config and pulls the vendored bundle the
     first time a diagram is rendered, on a hard load and after instant
     navigation alike. A <script> inside the content container does not work:
     instant navigation waits only for the last script of the container. */

  if (window.mermaid) return;

  var self = document.currentScript;
  var src = self.src.replace(/javascripts\/[^/]*$/, "artifacts/vendor/mermaid/11.17.2/mermaid.min.js");
  var config = null;
  var loading = null;

  var stub = {
    initialize: function (options) {
      config = options;
    },
    render: function (id, text) {
      return load().then(function (mermaid) {
        return mermaid.render(id, text);
      });
    }
  };

  function load() {
    if (!loading) {
      loading = new Promise(function (resolve, reject) {
        var script = document.createElement("script");
        script.src = src;
        script.onload = function () {
          /* the bundle replaces window.mermaid with the real library */
          if (window.mermaid === stub) return reject(new Error("mermaid bundle did not register: " + src));
          if (config) window.mermaid.initialize(config);
          resolve(window.mermaid);
        };
        script.onerror = function () {
          loading = null;
          reject(new Error("mermaid bundle failed to load: " + src));
        };
        document.head.appendChild(script);
      });
    }
    return loading;
  }

  window.mermaid = stub;
})();
