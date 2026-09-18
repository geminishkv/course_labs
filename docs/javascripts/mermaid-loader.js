(function () {
  "use strict";

  /* Self-hosted Mermaid, loaded on demand.
     Material renders diagrams through the global `mermaid` and fetches it from
     unpkg only when that global is missing; the site CSP blocks unpkg. This
     facade is the global: it takes Material's config, pulls the vendored bundle
     the first time a diagram is rendered and keeps sitting between Material and
     the library afterwards. A <script> inside the content container does not
     work: instant navigation waits only for the last script of the container. */

  if (window.mermaid) return;

  var self = document.currentScript;
  var src = self.src.replace(/javascripts\/[^/]*$/, "artifacts/vendor/mermaid/11.17.2/mermaid.min.js");
  var config = null;
  var library = null;
  var loading = null;

  /* Material paints diagram text with the site font through CSS, while Mermaid
     sizes SVG text boxes (sequence notes, messages, actors) with its own default
     font: the text then runs past its box. Give Mermaid the font that is really
     used, and colour lifelines, for which Material has no rule. */
  function withSiteFont(options) {
    var font = window.getComputedStyle(document.body).getPropertyValue("--md-mermaid-font-family").trim();
    var extra = " .actor-line{stroke:var(--md-mermaid-sequence-actor-line-color)}";
    var merged = Object.assign({}, options, { themeCSS: (options.themeCSS || "") + extra });
    if (font) {
      merged.fontFamily = font;
      merged.sequence = Object.assign({}, options.sequence, {
        actorFontFamily: font,
        noteFontFamily: font,
        messageFontFamily: font
      });
    }
    return merged;
  }

  /* A 780px diagram squeezed into a 360px phone leaves 7px text. Keep at least
     70% of the natural width; the host block scrolls sideways (typeset.css). */
  function keepReadable(result) {
    result.svg = result.svg.replace(/max-width:\s*([\d.]+)px;/, function (match, width) {
      return match + " min-width: " + Math.round(width * 0.7) + "px;";
    });
    return result;
  }

  function load() {
    if (!loading) {
      loading = new Promise(function (resolve, reject) {
        var script = document.createElement("script");
        script.src = src;
        script.onload = function () {
          /* the bundle replaces window.mermaid with the real library */
          if (window.mermaid === facade) return reject(new Error("mermaid bundle did not register: " + src));
          library = window.mermaid;
          window.mermaid = facade;
          if (config) library.initialize(config);
          resolve(library);
        };
        script.onerror = function () {
          loading = null;
          reject(new Error("mermaid bundle failed to load: " + src));
        };
        document.head.appendChild(script);
      });
    }
    /* text is measured with the site font, so the font has to be there first */
    var fonts = document.fonts && document.fonts.ready ? document.fonts.ready : Promise.resolve();
    return Promise.all([loading, fonts]).then(function (loaded) {
      return loaded[0];
    });
  }

  var facade = {
    initialize: function (options) {
      config = withSiteFont(options || {});
      if (library) library.initialize(config);
    },
    render: function (id, text) {
      return load().then(function (mermaid) {
        return mermaid.render(id, text);
      }).then(keepReadable);
    }
  };

  window.mermaid = facade;
})();
