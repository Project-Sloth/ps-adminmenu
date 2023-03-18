<script lang="ts">
  import '../main.css';
  import { fetchNui } from '@utils/fetchNui'
  import { SendNUI } from '@utils/SendNUI'
  import { onMount } from 'svelte';
  import Buttons from '@components/Buttons.svelte'
  import ButtonsDropdown from '@components/ButtonsDropdown.svelte'


/*   
  let ids: Array<number> = [];
  const getPlayers = async () => {
    const playerIds = await fetchNui<Array<number>>('getPlayers');
    ids = playerIds;
  }; 

  onMount(() => {
    getPlayers();
  });

  let filteredIds = ids;

  function handleChange(event) {
    const searchValue = event.target.value;
    filteredIds = ids.filter(id => id.toString().includes(searchValue.toLowerCase()));
  } 
*/

  let searchTerm = "";

  function toggleAll() {
  }

  function toggleFavorites() {
  }

  const buttons = [
    { 
      id: "admincar", // Id must be unique
      text: "Admin car", // Button Text
      fetchFunction: "getPlayers", // Name of the RegisterNUICallback 
      inputs: [], // keep empty if you dont want dropdown
      buttons: []  // keep empty if you dont want dropdown
    },
    { 
      id: "banplayer", // Id must be unique
      text: "Ban Player", // Button Text
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" }, // Placeholder is that input text, InputType is if you want a dropdown for the input, InputTypes: id, text, legth, moneytype
        { id: "reason", placeholder: "Reason", inputType: "text" },
        { id: "time", placeholder: "Length:", inputType: "length" }
      ],
      buttons: [
        { 
          id: "ban", placeholder: "Confirm", fetchFunction: "BanPlayer", // Placeholder is that button text, fetchFunction is the name of the RegisterNUICallback 
        },
      ] 
    },
    { 
      id: "bringplayer", 
      text: "Bring Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "bring", 
          placeholder: "Confirm",
          fetchFunction: "BringPlayer",
        },
      ] 
    },
    { 
      id: "changeweather", 
      text: "Change Weather", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "bring", 
          placeholder: "Confirm",
          fetchFunction: "BringPlayer",
        },
      ] 
    },
    { 
      id: "clearinventory", 
      text: "Clear Inventory", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "clearinv", 
          placeholder: "Confirm",
          fetchFunction: "ClearInv",
        },
      ] 
    },
    { 
      id: "clothingmenu", 
      text: "Clothing Menu", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "giveclothingmenu", 
          placeholder: "Confirm",
          fetchFunction: "GiveClothingMenu",
        },
      ] 
    },
    { 
      id: "customs", 
      text: "Customs", 
      fetchFunction: "ToggleCustoms", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "fixvehicle", 
      text: "Fix Vehicle", 
      fetchFunction: "FixVehicle", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "freezeplayer", 
      text: "Freeze Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "freezebutton", 
          placeholder: "Confirm",
          fetchFunction: "FreezePlayer",
        },
      ] 
    },
    { 
      id: "givemoney", 
      text: "Give Money", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "type", placeholder: "Type", inputType: "money" },
        { id: "amount", placeholder: "Amount:", inputType: "text" },
      ],
      buttons: [
        { 
          id: "givemoneybutton", 
          placeholder: "Confirm",
          fetchFunction: "GiveMoney",
        },
      ] 
    },
    { 
      id: "givenuifocus", 
      text: "Give Nui Focus", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "givenuifocus", 
          placeholder: "Confirm",
          fetchFunction: "GiveNuiFocus",
        },
      ] 
    },
    { 
      id: "god", 
      text: "God", 
      fetchFunction: "ToggleGodMode", 
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
      id: "kickplayer", 
      text: "Kick Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "reason", placeholder: "Reason", inputType: "text" },
      ],
      buttons: [
        { 
          id: "kick", 
          placeholder: "Confirm",
          fetchFunction: "KickPlayer", 
        },
      ] 
    },
    { 
      id: "kickall", 
      text: "Kick All", 
      fetchFunction: "KickAll", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "killplayer", 
      text: "Kill Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "kill", 
          placeholder: "Confirm",
          fetchFunction: "KillPlayer", 
        },
      ] 
    },
    { 
      id: "muteplayer", 
      text: "Mute Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "mute", 
          placeholder: "Confirm",
          fetchFunction: "MutePlayer", 
        },
      ] 
    },
    { 
      id: "noclip", 
      text: "Noclip", 
      fetchFunction: "ToggleNoClip", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "openinventory", 
      text: "Open Inventory", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "openinv", 
          placeholder: "Confirm",
          fetchFunction: "OpenPlayerInv", 
        },
      ] 
    },
    { 
      id: "reviveplayer", 
      text: "Revive Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "revive", 
          placeholder: "Confirm",
          fetchFunction: "RevivePlayer", 
        },
      ] 
    },
    { 
      id: "reviveall", 
      text: "Revive All", 
      fetchFunction: "ReviveAll", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "reviveRadius", 
      text: "Revive Radius", 
      fetchFunction: "ReviveRadius", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "setplayerjob", 
      text: "Set Job", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "job", placeholder: "Job", inputType: "text" },
        { id: "grade", placeholder: "Grade", inputType: "text" },
      ],
      buttons: [
        { 
          id: "setjob", 
          placeholder: "Confirm",
          fetchFunction: "SetPlayerJob", 
        },
      ] 
    },
    { 
      id: "spawncar", 
      text: "Spawn Car", 
      inputs: [
        { id: "vehicle", placeholder: "Vehicle", inputType: "text" },
      ],
      buttons: [
        { 
          id: "spawnvehicle", 
          placeholder: "Confirm",
          fetchFunction: "SpawnVehicle", 
        },
      ] 
    },
    { 
      id: "spectate", 
      text: "Spectate Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "spectateplayer", 
          placeholder: "Confirm",
          fetchFunction: "SpectatePlayer", 
        },
      ] 
    },
    { 
      id: "teleporttoplayer", 
      text: "Teleport To Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "teleportplayer", 
          placeholder: "Confirm",
          fetchFunction: "TeleportToPLayer", 
        },
      ] 
    },
    { 
      id: "teleporttocoords", 
      text: "Teleport to Coords", 
      inputs: [
        { id: "coords", placeholder: "Coords", inputType: "text" },
      ],
      buttons: [
        { 
          id: "teleportcoords", 
          placeholder: "Confirm",
          fetchFunction: "TeleportToCoords", 
        },
      ] 
    },
    { 
      id: "teleporttomarker", 
      text: "Teleport To Marker", 
      fetchFunction: "TeleportToMarker", 
      inputs: [],
      buttons: [] 
    },
    { 
      id: "unbanplayer", 
      text: "Unban Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "reason", placeholder: "Reason", inputType: "text" },
      ],
      buttons: [
        { 
          id: "unban", 
          placeholder: "Confirm",
          fetchFunction: "UnbanPlayer",
        },
      ] 
    },
    { 
      id: "uncuffplayer", 
      text: "Uncuff Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
      ],
      buttons: [
        { 
          id: "uncuff", 
          placeholder: "Confirm",
          fetchFunction: "UncuffPlayer",
        },
      ] 
    },
    { 
      id: "warnplayer", 
      text: "Warn Player", 
      inputs: [
        { id: "player", placeholder: "ID", inputType: "text" },
        { id: "reason", placeholder: "Reason", inputType: "text" },
      ],
      buttons: [
        { 
          id: "warn", 
          placeholder: "Confirm",
          fetchFunction: "WarnPlayer",
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

  const moneytypes = [
    { label: "Cash", type: "cash" },
    { label: "Bank", type: "bank" },
    { label: "Crypto", type: "crypto" },
  ];

  const weathertypes = [
    { label: "EXTRASUNNY", type: "cash" },
    { label: "CLEAR", type: "bank" },
    { label: "NEUTRAL", type: "crypto" },
    { label: "SMOG", type: "crypto" },
    { label: "FOGGY", type: "crypto" },
    { label: "OVERCAST", type: "crypto" },
    { label: "CLOUDS", type: "crypto" },
    { label: "CLEARING", type: "crypto" },
    { label: "RAIN", type: "crypto" },
    { label: "THUNDER", type: "crypto" },
    { label: "SNOW", type: "crypto" },
    { label: "BLIZZARD", type: "crypto" },
    { label: "SNOWLIGHT", type: "crypto" },
    { label: "XMAS", type: "crypto" },
    { label: "HALLOWEEN", type: "crypto" },
  ];


  function executeFetchFunction(btn, button) {
    const inputs = button.inputs.reduce((acc, input) => {
      acc[input.id] = document.querySelector(`#${input.id}_${button.id}`).value;
      return acc;
    }, {});
    console.log(btn.fetchFunction, JSON.stringify(inputs))
    fetchNui(btn.fetchFunction, inputs);
  }

  $: filteredButtons = buttons
  .filter(button => button.text.toLowerCase().includes(searchTerm.toLowerCase()))
  .sort((a, b) => a.text.localeCompare(b.text));

</script>

<div class="menu">
  <div class="button-container">
    <button class="button-all" on:click={toggleAll}>All</button>
    <button class="button-fav" on:click={toggleFavorites}>Favorites</button>
  </div>      
  <div class="search">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input class="search-input" placeholder="Search Actions" bind:value={searchTerm}>
  </div>
  <div class="buttons-container">
    {#each filteredButtons as button}
      {#if button.inputs.length === 0}
        <Buttons buttonText={button.text} fetchFunction={button.fetchFunction} id={button.id}/>
      {:else}
        <ButtonsDropdown buttonText={button.text} fetchFunction={button.fetchFunction} id={button.id}>
          <div class="dropdown-buttons-container">
            {#each button.inputs as input}
            <p class="dropdown-input-label">{input.placeholder}</p>
              {#if input.inputType === "length"}
                <select class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`} bind:value={input.sec}>
                  {#each lengths as length}
                    <option value={length.sec}>{length.label}</option>
                  {/each}
                </select>
              {:else if input.inputType === "money"}
              <select class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`} bind:value={input.type}>
                {#each moneytypes as moneytype}
                  <option value={moneytype.type}>{moneytype.label}</option>
                {/each}
              </select>
              {:else if input.inputType === "weather"}
              <select class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`} bind:value={input.type}>
                {#each weathertypes as weathertype}
                  <option value={weathertype.type}>{weathertype.label}</option>
                {/each}
              </select>
              {:else if input.inputType === "text"}
                <input class="dropdown-inputs" placeholder={input.placeholder} id={`${input.id}_${button.id}`}>
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
  height: 89.8%;
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
  width: 25rem;
  height: 3.4rem;
}

.dropdown-input-label {
  color: var(--textcolor);
}

.dropdown-buttons {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border: none;
  width: 12rem;
}

.options-container {
  background-color: var(--color-2);
  color: var(--textcolor);
  width: 25rem;
  height: 10rem;
  padding: 0.5rem;
  border-bottom-left-radius: 0.5rem;
  border-bottom-right-radius: 0.5rem;
  margin-bottom: 0.5rem;
  margin-top: -0.5rem;
  overflow-y: scroll;
}

</style>