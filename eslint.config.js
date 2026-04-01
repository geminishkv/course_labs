import js from "@eslint/js";

export default [
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
        fetch: "readonly",
        localStorage: "readonly",
        Promise: "readonly",
        console: "readonly",
        location: "readonly"
      }
    },
    rules: {
      "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
      "no-empty": ["error", { "allowEmptyCatch": true }]
    }
  }
];