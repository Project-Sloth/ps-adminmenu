module.exports = {
  darkmode: true,
  content: [
    "./index.html",
    "./src/**/*.{svelte,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: '#141517',
        secondary: '#1a1b1e',
        tertiary: '#24272b',
        accent: '#2284d9',
        border_primary: '#373a40',
        hover_secondary: '#2c2e33',
      }
    },
  },
  plugins: [],
}
