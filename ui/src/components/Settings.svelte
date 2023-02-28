<script>
  export let themes = [
    { name: "Project Sloth <3", colors: { "--color-1": "#222033", "--color-2": "#131121", "--color-3": "#222033", "--textcolor": "#c7c7c7", "--starcolor": "#02F1B5" } },
    { name: "Flashbang", colors: { "--color-1": "#FFFFFF", "--color-2": "#F0F0F0", "--color-3": "#ECECEC", "--textcolor": "#333333", "--starcolor": "#FFD700" } },
    { name: "Dark mode", colors: { "--color-1": "#1D1D1D", "--color-2": "#121212", "--color-3": "#333333", "--textcolor": "#EFEFEF", "--starcolor": "#02F1B5" } }
  ];

  let selected = themes[0].colors;

  function setTheme(theme) {
    selected = theme.colors;
    const root = document.documentElement;
    Object.entries(selected).forEach(([key, value]) => {
      root.style.setProperty(key, value);
    });

    // Save selected theme index in local storage
    const selectedThemeIndex = themes.indexOf(theme);
    localStorage.setItem("selectedThemeIndex", selectedThemeIndex.toString());
  }

  // Load selected theme index from local storage
  const savedThemeIndex = localStorage.getItem("selectedThemeIndex");
  if (savedThemeIndex) {
    selected = themes[parseInt(savedThemeIndex)].colors;
    setTheme(themes[parseInt(savedThemeIndex)]);
  }
</script>

<div class="settings">
  <div class="search">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input class="search-input" placeholder="Search..">
  </div>
  <ul class="settings-ul">
    <div class="theme-selector">
      <select on:change={(e) => setTheme(themes[e.target.value])}>
        {#each themes as theme, i}
          <option value={i} selected={selected === theme.colors}>{theme.name}</option>
        {/each}
      </select>
    </div>
  <ul>
</div>

<style>
.settings {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.search {
  border-bottom: 2px solid;
  color: var(--textcolor);
  margin: 4px;
}

.search-input {
  outline:none;
  width: 80%;
  padding: 0.7rem;
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
}

.settings-ul {
  height: 88%;
  overflow-y: scroll;
  padding: 1px;
}

.settings-button{
  padding: 0.8rem;
  width: 100%;
  background-color: var(--color-3);
  border: 1px solid var(--color-3);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  margin-top: 0.5rem;
  cursor: pointer;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  text-align: left;
}

.theme-selector {
  margin-bottom: 1rem;
}

.theme-selector select {
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
  outline: none;
  font-size: 1rem;
  padding: 0.5rem;
}

</style>