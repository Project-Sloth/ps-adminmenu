<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import { ACTIONSBUTTONS, ACTIONS, menuWideStore, PLAYERSBUTTONS, PLAYERS } from '@store/stores'
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

<div class="h-full font-medium {$menuWideStore.isMenuWide ? "w-[114vh] " : "w-[39vh]" }">
    <!-- TABS -->
    <div class="flex items-center text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <button class="w-full h-full hover:bg-tertiary {!showFavorites ? 'bg-tertiary' : ''}"
            on:click={() => (showFavorites = !showFavorites)}>
            All
        </button>
        <button class="w-full h-full hover:bg-tertiary {showFavorites ? 'bg-tertiary' : ''}"
            on:click={() => (showFavorites = !showFavorites)}>
            Favorites
        </button>
    </div>
    <!-- SEARCH -->
    <div class="flex items-center gap-[1vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <i class="fas fa-magnifying-glass ml-[1.5vh]"></i>
        <input type="text" placeholder="Search" class="w-[85%] h-full bg-transparent">
    </div>
    <!-- ACTIONS -->
    <div class="h-[78vh] flex flex-col items-center overflow-auto">
        {#if $ACTIONSBUTTONS && $ACTIONS}
            {#each $ACTIONS.filter(button => button.label.toLowerCase().includes(searchTerm.toLowerCase()) && (button.favorited || !showFavorites)).sort((a, b) => a.label.localeCompare(b.label)) as button, i}
                {#if button.dropdown}
                <div class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                    <!-- Dropdown Buttons -->
                    <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far hover:text-accent')} fa-star fa-lg "></i>
                    <button on:click={() => ToggleDropdown(i)}>
                        <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                    </button>
                    <i on:click={() => ToggleDropdown(i)} class="fa fa-{(dropdownActive[i] ? 'angle-down' : 'angle-right')} fa-lg ml-auto mr-1"></i>
                </div>
                    {#if dropdownActive[i]}
                    <div transition:fly="{{ y: -5, duration: 150 }}" class="-mt-6 bg-primary flex flex-col flex-wrap p-4 {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%] t')}">
                        {#each button.dropdown as dropdownItem}
                            {#if dropdownItem.InputType === 'input'}
                                <p class="font-medium mt-2">{dropdownItem.label}:</p>
                                <input
                                class="bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary"
                                type="text"
                                placeholder="{dropdownItem.label}"
                                value={inputValues[dropdownItem.label] || ''}
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
                <div class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                    <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far hover:text-accent')} fa-star fa-lg "></i>
                    <button
                    on:click={() => {SendNUI('normalButton', { event: button.event, type: button.type, perms: button.perms })}}>
                        <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                    </button>
                </div>

                {/if}
            {/each}
        {/if}
    </div>
</div>
