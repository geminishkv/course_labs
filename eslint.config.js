import js from "@eslint/js";

export default [
  js.configs.recommended,
  {
    files: ["docs/**/*.js", "javascripts/**/*.js"],
    languageOptions: {
      sourceType: "module",
      globals: {
        document: "readonly",
        window: "readonly",
        setTimeout: "readonly",
        clearTimeout: "readonly"
      }
    },
    rules: {
    }
  }
];