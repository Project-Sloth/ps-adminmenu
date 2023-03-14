<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
  import Buttons from '@components/Buttons.svelte'
  import ButtonsDropdown from '@components/ButtonsDropdown.svelte'

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
    { 
      id: "noclip", 
      text: "Noclip", 
      fetchFunction: "ToggleNoClip", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "invisible", 
      text: "Invisible", 
      fetchFunction: "ToggleInvis", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "banplayer", 
      text: "Ban Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "reason", placeholder: "Reason", inputType: "text" },
        { id: "time", placeholder: "Length", inputType: "length" }
      ],
      buttons: [
        { 
          id: "ban", 
          placeholder: "Ban",
          fetchFunction: "BanPlayer",
        },
      ] 
    },
    { 
      id: "kickplayer", 
      text: "Kick Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "reason", placeholder: "Reason", inputType: "text" },
      ],
      buttons: [
        { 
          id: "kick", 
          placeholder: "Kick",
          fetchFunction: "KickPlayer", 
        },
      ] 
    },
  ];

  const lengths = [
    { label: "10 Minutes", sec: "600" },
    { label: "30 Minutes", sec: "1800" },
    { label: "1 Hour", sec: "3600" },
    { label: "6 Hours", sec: "21600" },
    { label: "12 Hours", sec: "43200" },
    { label: "1 Day", sec: "86400" },
    { label: "3 Days", sec: "259200" },
    { label: "1 Week", sec: "604800" },
    { label: "Permanent", sec: "315360000" },
  ];

  const ids = ['1 - OK1ez Wilson', '2 - Dan Brown', '3 - OKie Davis', '4 - Daniel Wilson', '5 - William Davis'];


  function executeFetchFunction(btn, button) {
    const inputs = button.inputs.reduce((acc, input) => {
      acc[input.id] = document.querySelector(`#${input.id}_${button.id}`).value;
      return acc;
    }, {});
    console.log(btn.fetchFunction, JSON.stringify(inputs))
    fetchNui(btn.fetchFunction, inputs);
  }

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
    {#each buttons as button}
      {#if button.inputs.length === 0}
        <Buttons buttonText={button.text} fetchFunction={button.fetchFunction} id={button.id}/>
      {:else}
        <ButtonsDropdown buttonText={button.text} fetchFunction={button.fetchFunction} id={button.id}>
          <div class="dropdown-buttons-container">
            {#each button.inputs as input}
              {#if input.inputType === "id"}
              <select class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`} bind:value={input.sec}>
                {#each ids as id}
                  <option value={id}>{id}</option>
                {/each}
              </select>
              {:else if input.inputType === "text"}
              <input class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`}>
              {:else if input.inputType === "length"}
              <select class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`} bind:value={input.sec}>
                {#each lengths as length}
                  <option value={length.sec}>{length.label}</option>
                {/each}
              </select>
              {/if}
            {/each}
            {#each button.buttons as btn}
            <button class="dropdown-buttons" on:click={() => executeFetchFunction(btn, button)}>{btn.placeholder}</button>
          {/each}          
          </div>
        </ButtonsDropdown>
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