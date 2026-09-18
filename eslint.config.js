import js from "@eslint/js";

export default [
  // vendored third-party bundles are not ours to lint
  { ignores: ["docs/artifacts/vendor/**"] },
  js.configs.recommended,
  {
    files: ["docs/**/*.js", "javascripts/**/*.js"],
    languageOptions: {
      sourceType: "script",
      globals: {
        document: "readonly",
        window: "readonly",
        setTimeout: "readonly",
        clearTimeout: "readonly",
        setInterval: "readonly",
        clearInterval: "readonly",
        fetch: "readonly",
        localStorage: "readonly",
        sessionStorage: "readonly",
        Promise: "readonly",
        console: "readonly",
        location: "readonly",
        navigator: "readonly",
        IntersectionObserver: "readonly",
        requestAnimationFrame: "readonly",
        cancelAnimationFrame: "readonly",
        performance: "readonly",
        document$: "readonly"
      }
    },
    rules: {
      "no-unused-vars": ["error", { "argsIgnorePattern": "^_", "varsIgnorePattern": "^_", "caughtErrorsIgnorePattern": "^_" }],
      "no-empty": ["error", { "allowEmptyCatch": true }]
    }
  }
];