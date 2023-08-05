<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import { ACTIONSBUTTONS, ACTIONS, menuWideStore, PLAYERSBUTTONS, PLAYERS, VEHICLES } from '@store/stores'
    import { SendNUI } from '@utils/SendNUI'
    import { fly } from 'svelte/transition';

    const dropdownActive = Array().fill(false);

    function ToggleDropdown(index: number) {
        dropdownActive[index] = !dropdownActive[index];

        inputValues[index] = {};
    }
    let showFavorites = false;
    let searchTerm = '';
    let inputValues: {[key: string]: string}[] = [];
    let selectedPlayerId = '';

    function updateInputValue(dropdownIndex: number, label: string, value: string) {
        if (label === 'playerid') {
        selectedPlayerId = value;
        } else {
        inputValues[dropdownIndex][label] = value;
        }
    }

  let searchQuery = '';
  let selectedOption = '';

  const dispatch = createEventDispatcher();

  function handleInputChange(event) {
    searchQuery = event.target.value;
  }

  function selectOption(option) {
    if (searchQuery !== selectedPlayerId) {
      searchQuery = option;
    }
    selectedOption = option;
    dispatch('optionSelected', option);
  }

</script>

<div class="w-full h-full flex flex-col">
    <!-- Tabs -->
    <div class="w-full h-[5.5rem] flex border-b-2 border-tertiary">
        <button class="w-full h-full hover:bg-tertiary font-medium {(!showFavorites ? 'bg-tertiary' : '')}" on:click={() => (showFavorites = !showFavorites)} >All</button>
        <button class="w-full h-full hover:bg-tertiary font-medium {(showFavorites ? 'bg-tertiary' : '')}" on:click={() => (showFavorites = !showFavorites)} >Favorites</button>
    </div>
    <!-- SearchBar -->
    <div class="h-[5.5rem] w-full border-b-2 border-tertiary flex items-center justify-center">
        <input class="ml-8 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search" bind:value={searchTerm}>
    </div>
    <!-- Button List -->
    <div class="w-full h-[88.5%] flex items-center flex-col overflow-auto ">
        {#if $ACTIONSBUTTONS && $ACTIONS}
        {#each $ACTIONS.filter(button => button.label.toLowerCase().includes(searchTerm.toLowerCase()) && (button.favorited || !showFavorites)).sort((a, b) => a.label.localeCompare(b.label)) as button, i}
                {#if button.dropdown}
                    <!-- Dropdown Buttons -->
                    <button
                        on:click={() => ToggleDropdown(i)}
                        class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                        <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far hover:text-accent')} fa-star fa-lg "></i>
                        <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                        <i class="fa fa-{(dropdownActive[i] ? 'angle-down' : 'angle-right')} fa-lg ml-auto"></i>
                    </button>
                    {#if dropdownActive[i]}
                    <div transition:fly="{{ y: -5, duration: 150 }}" class="-mt-6 bg-primary flex flex-col flex-wrap p-4 {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%] t')}">
                        {#each button.dropdown as dropdownItem}
                            {#if dropdownItem.InputType === 'input'}
                                <p class="font-medium mt-2">{dropdownItem.label}:</p>
                                <input
                                class="bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary"
                                type="text"
                                placeholder="{dropdownItem.label}"
                                value={inputValues[dropdownItem.label]}
                                on:input={(event) => updateInputValue(i, dropdownItem.label, event.currentTarget.value)}
                                >
                            {:else if dropdownItem.InputType === 'options'}
                                <p class="font-medium mt-2">{dropdownItem.label}:</p>
                                <select
                                    class="bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary"
                                    value={inputValues[dropdownItem.label]}
                                    on:input={(event) => updateInputValue(i, dropdownItem.label, event.currentTarget.value)}
                                    >
                                    {#each dropdownItem.options as option}
                                        <option value={option.value}>{option.label}</option>
                                    {/each}
                                </select>
                            {:else if dropdownItem.InputType === 'playerid'}
                                <div class="bg-secondary w-[25rem] mt-1 font-medium ">
                                    <input type="text" value={searchQuery} on:input={handleInputChange} on:input={(event) => updateInputValue(i, dropdownItem.label, searchQuery)} placeholder="Search..." class=" bg-transparent py-3 ml-2" />
                                    {#if searchQuery}
                                      <div class="">
                                        {#if $PLAYERSBUTTONS && $PLAYERS}
                                        {#each $PLAYERS.filter(button => button.name.toLowerCase().includes(searchQuery.toLowerCase())) as button, i}
                                            <div class="p-3" on:click={() => selectOption(button.id)}>{button.name}</div>
                                            {/each}
                                        {/if}
                                      </div>
                                    {/if}
                                  </div>
                            {:else if dropdownItem.InputType === 'players'}
                                <p class="font-medium mt-2">{dropdownItem.label}:</p>
                                <select
                                    class="bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary"
                                    value={inputValues[dropdownItem.label]}
                                    on:input={(event) => updateInputValue(i, dropdownItem.label, event.currentTarget.value)}
                                    >
                                    {#if $PLAYERSBUTTONS && $PLAYERS}
                                        {#each $PLAYERS.filter(button => button.name.toLowerCase().includes(searchQuery.toLowerCase())) as button, i}
                                            <div class=" hover:bg-primary p-3" on:click={() => selectOption(button.name)}>{button.name}</div>
                                            <option value={button.id}>{button.name}</option>
                                            {/each}
                                    {/if}
                                </select>
                            {:else if dropdownItem.InputType === 'personalveh'}
                            {#if $VEHICLES}
                            <p class="font-medium mt-2">{dropdownItem.label}:</p>
                            <select
                                    class="bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary"
                                    value={inputValues[dropdownItem.label]}
                                    on:input={(event) => updateInputValue(i, dropdownItem.label, event.currentTarget.value)}
                                    >
                                        {#each $VEHICLES.filter(button => button.label) as button}
                                            <div class=" hover:bg-primary p-3" on:click={() => selectOption(button.label)}>{button.label}</div>
                                            <option value={button.plate}>{button.label}</option>
                                        {/each}
                                    </select>
                                {/if}
                            {:else if dropdownItem.InputType === 'button'}
                                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary"
                                    on:click={() => {
                                        if (dropdownItem.label === 'playerid') {
                                            SendNUI("normalButton", {
                                                event: dropdownItem.event,
                                                type: dropdownItem.type,
                                                data: selectedPlayerId,
                                                button: dropdownItem.label,
                                                perms: button.perms
                                            });
                                        } else {
                                            SendNUI("normalButton", {
                                                event: dropdownItem.event,
                                                type: dropdownItem.type,
                                                data: inputValues[i],
                                                button: dropdownItem.label,
                                                perms: button.perms
                                            });
                                        }
                                    }}
                                    >
                                    {dropdownItem.label}
                                </button>
                            {/if}
                        {/each}
                      </div>
                  {/if}
                {:else}
                <!-- Normal Buttons -->
                <button
                    on:click={() => {
                        SendNUI('normalButton', { event: button.event, type: button.type, perms: button.perms });
                    }}
                    class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                    <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far hover:text-accent')} fa-star fa-lg "></i>
                    <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                </button>
                {/if}
            {/each}
        {/if}
    </div>

</div>
