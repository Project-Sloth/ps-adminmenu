<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
  import { slide } from 'svelte/transition'
	import Buttons from '@components/Buttons.svelte'
  import ButtonsDropdown  from '@components/ButtonsDropdown.svelte'


  let searchTerm = "";
  let showDropdownBanplayer = false;
  let showDropdownBringplayer = false;
  let showDropdownKickplayer = false;
  let showDropdownTeleportCoords = false;
  let showThemesDropdown = false;

  let selectedAdmincar = localStorage.getItem("selectedAdmincar") === "true" || undefined;

  let selectedBanplayer = localStorage.getItem("selectedBanplayer") === "true" || false;
  let selectedBringplayer = localStorage.getItem("selectedBringplayer") === "true" || false;
  let selectedClothing = localStorage.getItem("selectedClothing") === "true" || false;
  
  let selectedInvisible = localStorage.getItem("selectedInvisible") === "true" || false;
  let selectedKickplayer = localStorage.getItem("selectedKickplayer") === "true" || false;
  let selectedTeleportCoords = localStorage.getItem("selectedTeleportCoords") === "true" || false;


  function setSearchTerm(event) {
    searchTerm = event.target.value.toLowerCase();
  }

  function toggleDropdownBanplayer() {
    showDropdownBanplayer = !showDropdownBanplayer;
  }

  function toggleDropdownKickplayer() {
    showDropdownKickplayer = !showDropdownKickplayer;
  }

  function toggleDropdownBringplayer() {
    showDropdownBringplayer = !showDropdownBringplayer;
  }

  function toggleDropdownTeleportCoords() {
    showDropdownTeleportCoords = !showDropdownTeleportCoords;
  }

  function toggleThemesDropdown() {
    showThemesDropdown = !showThemesDropdown;
  }


  function toggleSelectionBanplayer(event) {
    selectedBanplayer = !selectedBanplayer;
    event.stopPropagation();
    localStorage.setItem("selectedBanplayer", selectedBanplayer);
  }

  function toggleSelectionBringplayer(event) {
    selectedBringplayer = !selectedBringplayer;
    event.stopPropagation();
    localStorage.setItem("selectedBringplayer", selectedBringplayer);
  }

  function toggleSelectionClothing(event) {
    selectedClothing = !selectedClothing;
    event.stopPropagation();
    localStorage.setItem("selectedClothing", selectedClothing);
  }

  function toggleSelectionInvisible(event) {
    selectedInvisible = !selectedInvisible;
    event.stopPropagation();
    localStorage.setItem("selectedInvisible", selectedInvisible);
  }
  function toggleSelectionKickplayer(event) {
    selectedKickplayer = !selectedKickplayer;
    event.stopPropagation();
    localStorage.setItem("selectedKickplayer", selectedKickplayer);
  }
  function toggleSelectionTeleportCoords(event) {
    selectedTeleportCoords = !selectedTeleportCoords;
    event.stopPropagation();
    localStorage.setItem("selectedTeleportCoords", selectedTeleportCoords);
  }

  function toggleSelectionThemes(event) {
    selectedThemes = !selectedThemes;
    event.stopPropagation();
    localStorage.setItem("selectedThemes", selectedThemes);
  }


  function toggleInvis() { fetchNui("ToggleInvis"); }
  function toggleClothing() {
    fetchNui("ToggleClothing");
    visibility.set(false);
    fetchNui("hideUI");
  }


  let showAll = true;
  let showFavorites = false;

  function toggleAll() {
    showAll = true;
    showFavorites = false;
  }

  function toggleFavorites() {
    showAll = false;
    showFavorites = true;
  }

function banPlayer() {
  const idInput = document.querySelector('input[placeholder="ID"]');
  const reasonInput = document.querySelector('input[placeholder="Reason"]');
  const timeInput = document.querySelector('input[placeholder="Length"]');

  const player = idInput.value;
  const reason = reasonInput.value;
  const time = timeInput.value;

  // Send the ban request to the server using fetchNui
  fetchNui('banPlayer', { player, reason, time });
  console.log(player, reason, time);
}

</script>

    
<div class="menu">
  <div class="button-container">
    <button class="button-all" on:click={() => {showFavorites = false}}>All</button>
    <button class="button-fav" on:click={() => {showFavorites = true}}>Favorites</button>
  </div>      
  <div class="search">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input class="search-input" placeholder="Search.." bind:value={searchTerm}>
  </div>
  <div class="buttons-container">
    
    <Buttons buttonText={'Noclip'} fetchFunction={'ToggleNoClip'} id="noclip"/>
    
    <ButtonsDropdown buttonText={'Admincar'} fetchFunction={'ToggleAdmincar'} id="admincar">
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="Coords">
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>

      </div>
    </ButtonsDropdown>

    <ButtonsDropdown buttonText={'Admincar'} fetchFunction={'ToggleAdmincar'} id="admincar">
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>
      </div>
    </ButtonsDropdown>

    <ButtonsDropdown buttonText={'Admincar'} fetchFunction={'ToggleAdmincar'} id="admincar">
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>
       <button class="dropdown-buttons" on:click={() => console.log('Teleport button clicked')}>Teleport</button>
      </div>
    </ButtonsDropdown>

    
 
  </div>
</div>

<style>

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

.menu {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.buttons-container {
  height: 87%;
  overflow-y: scroll;
  padding: 1px;
  margin-top: 1rem;
}

.button-all {
  border: none;
  background-color: var(--color-2);
  color: var(--textcolor);
  width: 40px;
  height: 35px;
  text-align: center;
  vertical-align: middle;
}

.button-fav {
  border: none;
  background-color: var(--color-2);
  color: var(--textcolor);
  margin-left: 5px;
  width: 75px;
  height: 35px;
  text-align: center;
  vertical-align: middle;
}

.dropdown-buttons-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
  flex-direction: column;
  margin-left: -4rem;
}

.dropdown-inputs {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border-radius: 0.15rem; 
  border: none;
  width: 70%;
}

.dropdown-buttons {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border: none;
  width: 30%;
}


</style>