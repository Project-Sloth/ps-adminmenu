<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
  import { onMount } from 'svelte'
  import { slide } from 'svelte/transition';

  let searchTerm = "";
  let showAll = true;

  function toggleAllFav(showFavorites) {
    showAll = !showFavorites;
  }

  function toggleFavorite(index) {
    buttons[index].favorite = !buttons[index].favorite;
  }

  const buttons = [
    { id: "noclip", label: "Noclip", fetchFunction: "ToggleNoClip", favorite: false },
    { id: "invisible", label: "Invisible", fetchFunction: "ToggleInvis", favorite: false },
    {
      id: "banplayer",
      label: "Ban Player",
      dropdown: {
        items: [
          { type: "input", label: "Player ID", id: "playerId", inputType: "id" },
          { type: "input", label: "Reason", id: "banReason" },
          { type: "input", label: "Length", id: "banDuration", inputType: "length" },
          { type: "button", label: "Ban", id: "banButton", action: "banPlayer" },
        ]
      },
      showDropdown: false,
      favorite: false
    },
    {
      id: "kickplayer",
      label: "Kick Player",
      dropdown: {
        items: [
          { type: "input", label: "Player ID", id: "playerId", inputType: "id" },
          { type: "input", label: "Reason", id: "kickReason" },
          { type: "button", label: "Kick", id: "kickButton", action: "kickPlayer" },
        ]
      },
      showDropdown: false,
      favorite: false
    },
  ];

  const ids = ['1 - OK1ez Wilson', '2 - Dan Brown', '3 - OKie Davis', '4 - Daniel Wilson', '5 - William Davis'];
  const lengths = ['10 Minutes', '30 Minutes', '1 Hour', '6 Hours', '12 Hours', '1 Day', '3 Day', '1 Week', 'Permanent'];


  function toggleDropdown(index) {
    buttons[index].showDropdown = !buttons[index].showDropdown;
  }


  onMount(() => {
    document.addEventListener('click', (event) => {
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
  if (searchTerm === "") {
    return true;
  } else {
    return button.label.toLowerCase().includes(searchTerm.toLowerCase());
  }
});

</script>


<div class="menu">
  <div class="button-container">
    <button class="button-all-fav" on:click={() => toggleAllFav(false)}>All</button>
    <button class="button-all-fav" on:click={() => toggleAllFav(true)}>Favorites</button>
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
          <i class="icon {button.favorite ? 'fas fa-star icon-selected' : 'far fa-star'}" on:click={() => toggleFavorite(i)}></i>
          {button.label}
          <i class="fas fa-angle-right dropdown-icon" style="transform: rotate({button.showDropdown ? 90 : 0}deg);"></i>
        </button>
        {#if button.showDropdown}
          <div class="dropdown-buttons-container" transition:slide="{{duration: 300}}">
            {#each button.dropdown.items as item}
            {#if item.type === "input" && item.inputType === "id"}
              <select class="dropdown-inputs" id={item.id}>
                {#each ids as id}
                  <option value={id}>{id}</option>
                {/each}
              </select>
            {:else if item.type === "input" && item.inputType === "length"}
            <select class="dropdown-inputs" id={item.length}>
              {#each lengths as length}
                <option value={length}>{length}</option>
              {/each}
            </select>
            {:else if item.type === "input"}
              <input class="dropdown-inputs" placeholder={item.label} id={item.id}>
            {:else if item.type === "button"}
              <button class="dropdown-buttons" on:click={() => fetchNui(item.action)}>{item.label}</button>
            {/if}
          {/each}
          
          </div>
        {/if}
      </div>
    {:else}
    <button class="menu-button" on:click={() => fetchNui(button.fetchFunction)}>
      <i class="icon {button.favorite ? 'fas fa-star icon-selected' : 'far fa-star'}" on:click={() => toggleFavorite(i)}></i>
      {button.label}
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

.button-all-fav {
  border: none;
  background-color: var(--color-2);
  color: var(--textcolor);
  width: 40px;
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

.menu-button .fa-angle-right {
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