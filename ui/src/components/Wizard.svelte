<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
  import { onMount } from 'svelte'
  import Buttons from '@components/Buttons.svelte'
  import ButtonsDropdown  from '@components/ButtonsDropdown.svelte'
  import { slide } from 'svelte/transition';


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

  const buttons = [
    { id: "noclip", text: "Noclip", fetchFunction: "ToggleNoClip" },
    { id: "invisible", text: "Invisible", fetchFunction: "ToggleInvis" },
    {
      id: "banplayer",
      text: "Ban Player",
      dropdown: {
        items: [
          { type: "input", name: "playerId", label: "Player ID" },
          { type: "input", name: "banReason", label: "Ban Reason" },
          { type: "input", name: "banDuration", label: "Ban Duration" },
          { type: "button", name: "banButton", label: "Ban", action: "banPlayer" },
        ]
      },
      showDropdown: false 
    },
  ];

  function toggleDropdown(index) {
    buttons[index].showDropdown = !buttons[index].showDropdown;
  }

  onMount(() => {
    document.addEventListener('click', (event) => {
      // Hide dropdowns when clicking outside of them
      buttons.forEach((button) => {
        if (button.showDropdown && !event.target.closest(`#dropdown-${button.id}`)) {
          button.showDropdown = false;
        }
      });
    });
  });

  $: filteredButtons = buttons.filter((button) => {
  if (!showAll && !button.favorite) {
    return false;
  }
  if (!showFavorites && button.favorite) {
    return false;
  }
  if (searchTerm === "") {
    return true;
  } else {
    return button.text.toLowerCase().includes(searchTerm.toLowerCase());
  }
});


</script>
<div class="menu">
  <div class="button-container">
    <button class="button-all" on:click={toggleAll}>All</button>
    <button class="button-fav" on:click={toggleFavorites}>Favorites</button>
  </div>      
  <div class="search">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input class="search-input" placeholder="Search.." bind:value={searchTerm}>
  </div>
  <div class="buttons-container">
    {#each filteredButtons as button, i}
    {#if button.dropdown}
      <div id={`dropdown-${button.id}`} class="dropdown">
        <button class="menu-button" on:click={() => toggleDropdown(i)}>
          {button.text}
          <i class="fas fa-angle-right dropdown-icon" style="transform: rotate({button.showDropdown ? 90 : 0}deg);"></i>
        </button>
        {#if button.showDropdown}
          <div class="dropdown-buttons-container" transition:slide="{{duration: 300}}">
            {#each button.dropdown.items as item}
              {#if item.type === "input"}
                <input class="dropdown-inputs" placeholder={item.label} id={item.name}>
              {:else if item.type === "button"}
                <button class="dropdown-buttons" on:click={() => fetchNui(item.action)}>{item.label}</button>
              {/if}
            {/each}
          </div>
        {/if}
      </div>
    {:else}
    <button class="menu-button" on:click={() => fetchNui(button.fetchFunction)}>
      <i class="icon far fa-star"></i>
      {button.text}
    </button>
    
    {/if}
  {/each}
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

.dropdown-toggle .fa-angle-right {
  transition: transform 0.3s ease;
}

.menu-button {
    padding: 1rem;
    width: 100%;
    background-color: var(--color-3);
    color: var(--textcolor);
    font-family: 'Roboto', sans-serif;
    margin-top: 0.5rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: var(--textcolor);
  }

  .icon {
    margin-right: 1rem;
    color: var(--textcolor);
  }

  .icon-selected {
    color: var(--starcolor);
  }

  .dropdown-icon {
    margin-left: auto;
    margin-right: 1rem;
  }

  .dropdown {
    background-color: var(--color-3);
  }

  .dropdown-buttons-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
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
  width: 80%;
  margin-left: 0.5rem;
}

.dropdown-buttons {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  margin-left: 0.5rem;
  border: none;
  width: 30%;
}
</style>