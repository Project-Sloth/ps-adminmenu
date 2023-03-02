<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
	import Buttons from '@components/Buttons.svelte'
  import ButtonsDropdown  from '@components/ButtonsDropdown.svelte'

  let searchTerm = "";
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
    
    <!-- Normal Button -->
    <Buttons buttonText={'Noclip'} fetchFunction={'ToggleNoClip'} id="noclip"/>
    
    <!-- Dropdown Button -->
    <ButtonsDropdown buttonText={'Ban Player'} fetchFunction={'BanPlayer'} id="banplayer">
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="ID">
        <input class="dropdown-inputs" placeholder="Reason">
        <input class="dropdown-inputs" placeholder="Time">
       <button class="dropdown-buttons">Ban Player</button>
      </div>
    </ButtonsDropdown>

    <ButtonsDropdown buttonText={'Admincar'} fetchFunction={'ToggleAdmincar'} id="admincar">
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
       <button class="dropdown-buttons">Teleport</button>
      </div>
    </ButtonsDropdown>

    <ButtonsDropdown buttonText={'Admincar'} fetchFunction={'ToggleAdmincar'} id="admincar" on:click={() => console.log('Teleport button clicked')} >
      <div class="dropdown-buttons-container">
        <input class="dropdown-inputs" placeholder="Coords">
        <input class="dropdown-inputs" placeholder="Coords">
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
  width: 110%;
}

.dropdown-buttons {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border: none;
  width: 70%;
}


</style>