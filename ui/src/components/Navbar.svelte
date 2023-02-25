<script lang="ts">
    import '../main.css';
    import { fetchNui } from '@utils/fetchNui'
    import Wizard from './Wizard.svelte';
    import List from './List.svelte';
    import Server from './Server.svelte';
    import Reports from './Reports.svelte';
    import Settings from './Settings.svelte';
  
    export let isMenuLarge = false;
    let isMenuHidden = false;
    let DevMode = false;
    let DebugMode = false;
    let showThemes = false;
    let currentPage = 'wizard';
  
    function toggleMenu() { isMenuLarge = !isMenuLarge; }
    function showSettings() { currentPage = 'settings'; }
    function showWizard() { currentPage = 'wizard'; }
    function showList() { currentPage = 'list'; }
    function showServer() { currentPage = 'server'; }
    function showReports() { currentPage = 'reports'; }
    function toggleDevMode() { DevMode = !DevMode; fetchNui("ToggleDevMode"); }
  </script>
  
  <div class="container {isMenuLarge ? 'open' : ''}">
    <div class="sidebar">
      <button on:click={showSettings} aria-label="Settings" style="margin-bottom: 0.7rem;">
        <i class="fas fa-gear"></i>
      </button>
      <button on:click={toggleDevMode} style="color: {DevMode ? 'var(--starcolor)' : 'var(--textcolor)'}" aria-label="Dev Mode">
        <i class="fas fa-terminal"></i>
      </button>
      <button on:click={showWizard} aria-label="Wizard">
        <i class="fas fa-hat-wizard"></i>
      </button>
      <button on:click={showList} aria-label="List">
        <i class="fas fa-list"></i>
      </button>
      <button on:click={showServer} aria-label="Server">
        <i class="fas fa-server"></i>
      </button>
      <button on:click={showReports} aria-label="Reports">
        <i class="fas fa-message"></i>
      </button>
      <button on:click={toggleMenu}>
        <i class="fas fa-angle-left" id="icon" style="margin-bottom: 36.6rem;transform: rotate({isMenuLarge ? 180 : 0}deg);"></i>
      </button>
    </div>
  
    {#if currentPage === 'wizard'}
      <Wizard />
    {:else if currentPage === 'list'}
      <List />
    {:else if currentPage === 'server'}
      <Server />
    {:else if currentPage === 'reports'}
      <Reports />
    {:else if currentPage === 'settings'}
      <Settings />
    {/if}
  </div>

<style>

.container {
  display: flex;
  position: fixed;
  top: 50%;
  right: 2%;
  transform: translateY(-50%);
  width: 22%;
  height: 650px;
  transition: all 0.5s ease-in-out;
  background-color: var(--color-1);
}

.container.open {
  right: 0%;
  transform: translate(-50%, -50%);
  width: 50%;
}

.sidebar {
  background-color: var(--color-1);
  padding: 1.2rem;
  height: 100%;
  display: flex;
  flex-direction: column-reverse;
}

.sidebar button {
  display: block;
  margin-top: 1.5rem;
  background-color: transparent;
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  border: none;
  cursor: pointer;
}

</style>