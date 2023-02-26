<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
	import Button from '@components/Button.svelte'

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
  let selectedNoclip = localStorage.getItem("selectedNoclip") === "true" || false;
  let selectedInvisible = localStorage.getItem("selectedInvisible") === "true" || false;
  let selectedKickplayer = localStorage.getItem("selectedKickplayer") === "true" || false;
  let selectedTeleportCoords = localStorage.getItem("selectedTeleportCoords") === "true" || false;
  let selectedThemes = localStorage.getItem("selectedThemes") === "true" || false;


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
  function toggleSelectionNoclip(event) {
    selectedNoclip = !selectedNoclip;
    event.stopPropagation();
    localStorage.setItem("selectedNoclip", selectedNoclip);
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

  function toggleAdmincar() { fetchNui("toggleAdmincar");}
  function toggleNoclip() { fetchNui("ToggleNoClip"); }
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
    <div class="button-container" style="display: flex; justify-content: flex-start; align-items: center; margin-top: -4.5px; margin-left: 5px;">
      <button style="border: none; background-color: var(--color-2); width: 40px; height: 35px; text-align: center; vertical-align: middle;" on:click={() => {showFavorites = false}} on:keydown={e => {if(e.key === 'Enter') {}}}>All</button>
      <button style="border: none; background-color: var(--color-2); margin-left: 5px;width: 75px; height: 35px; text-align: center; vertical-align: middle;" on:click={() => {showFavorites = true}} on:keydown={e => {if(e.key === 'Enter') {}}}>Favorites</button>
      </div>      
      <div class="search" style="display: flex; align-items: center;  margin-left: 2px;">
        <i style="color:var(--textcolor); margin-left: 2px;margin-right: 5px;" class="fas fa-search"></i>
        <input type="text" style="outline:none;" placeholder="Search.." bind:value={searchTerm}>
      </div>
      <ul>

      {#if (searchTerm === '' || 'Admin Car'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedAdmincar)}
        <!-- <button style="display: flex; align-items: center;" on:click={toggleAdmincar}>
          <i class={`far fa-star ${selectedAdmincar ? 'fas' : 'far'}`} on:click={toggleSelectionAdmincar} style="margin-right: 10px; color: {selectedAdmincar ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Admin Car'} 
        </button> -->
        <Button />
      {/if}
    
        
        {#if (searchTerm === '' || 'Ban Player'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedBanplayer)}
        <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownBanplayer}>
          <i class={`far fa-star ${selectedBanplayer ? 'fas' : 'far'}`} on:click={toggleSelectionBanplayer} style="margin-right: 10px; color: {selectedBanplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Ban Player'} 
          <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownBanplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
        </button>
              
        {#if showDropdownBanplayer}
        <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 1rem;height: -20px; overflow: hidden; transition: height 1.5s ease-in-out;">
          <!-- Your dropdown menu content goes here -->
          <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
            <input type="text" placeholder="ID" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <input type="text" placeholder="Reason" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <input type="text" placeholder="Length" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Ban</button>
          </div>
        </div>
        {/if}
      {/if}

        {#if (searchTerm === '' || 'Bring Player'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedBringplayer)}
        <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownBringplayer}>
          <i class={`far fa-star ${selectedBringplayer ? 'fas' : 'far'}`} on:click={toggleSelectionBringplayer} style="margin-right: 10px; color: {selectedBringplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Bring Player'} 
          <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownBringplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
        </button>
      
        {#if showDropdownBringplayer}
        <div style="background-color: var(--color-3);padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 4.7rem; height: 0px; overflow: hidden; transition: height 1.5s ease-in-out;">
            <!-- Your dropdown menu content goes here -->
            <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
              <input type="text" placeholder="ID" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
              <button style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Submit</button>
            </div>
            
          </div>
        {/if}
      {/if}

        <!-- Click Button-->
        {#if (searchTerm === '' || 'Clothing Menu'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedClothing)}
        <button style="display: flex; align-items: center;" on:click={toggleClothing}>
          <i class={`far fa-star ${selectedClothing ? 'fas' : 'far'}`} on:click={toggleSelectionClothing} style="margin-right: 10px; color: {selectedClothing ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Clothing Menu'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Customs'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Customs'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Change Weather'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Change Weather'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Fix Vehicle'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Fix Vehicle'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'God'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'God'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Give Cash'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give Cash'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Give Item'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give Item'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Give License'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give License'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Invisible'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedInvisible)}
        <button style="display: flex; align-items: center;" on:click={toggleInvis}>
          <i class={`far fa-star ${selectedInvisible ? 'fas' : 'far'}`} on:click={toggleSelectionInvisible} style="margin-right: 10px; color: {selectedInvisible ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Invisible'} 
        </button>
      {/if}

      {#if (searchTerm === '' || 'Kick'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedKickplayer)}
      <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownKickplayer}>
        <i class={`far fa-star ${selectedKickplayer ? 'fas' : 'far'}`} on:click={toggleSelectionKickplayer} style="margin-right: 10px; color: {selectedKickplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Kick'} 
        <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownKickplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
      </button>
            
      {#if showDropdownKickplayer}
      <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 8.5rem;height: 0px; overflow: hidden; transition: height 1.5s ease-in-out;">
        <!-- Your dropdown menu content goes here -->
        <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
          <input type="text" placeholder="ID" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
          <input type="text" placeholder="Reason" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
          <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Kick</button>
        </div>
      </div>
      {/if}
    {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Noclip'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Noclip'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Revive'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Revive'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Revive in Radius'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Revive in Radius'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Spawn Car'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Spawn Car'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Teleport'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport'} 
        </button>
      {/if}

      <!-- Click Button-->

      {#if (searchTerm === '' || 'Teleport Coords'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedTeleportCoords)}
      <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownTeleportCoords}>
        <i class={`far fa-star ${selectedTeleportCoords ? 'fas' : 'far'}`} on:click={toggleSelectionTeleportCoords} style="margin-right: 10px; color: {selectedTeleportCoords ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport Coords'} 
        <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownTeleportCoords ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
      </button>
            
      {#if showDropdownTeleportCoords}
      <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 4.5rem;height: 27px; overflow: hidden; transition: height 1.5s ease-in-out;">
        <!-- Your dropdown menu content goes here -->
        <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
          <input type="text" placeholder="Coords" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
          <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Teleport</button>
        </div>
      </div>
      {/if}
    {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Teleport Marker'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport Marker'} 
        </button>
      {/if}

      <!-- Click Button-->
      {#if (searchTerm === '' || 'Unban'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
        <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
          <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Unban'} 
        </button>
      {/if}

    </ul>
  </div>

<style>

.search {
  border-bottom: 2px solid;
  color: var(--textcolor);
}

.search input {
  width: 50%;
  padding: .7rem;
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

.menu ul {
  margin-top: 10px;
  height: 87%;
  overflow-y: scroll;
  padding: 1px;
}

.menu button {
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

</style>