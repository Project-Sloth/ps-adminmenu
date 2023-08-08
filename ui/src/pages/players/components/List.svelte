<script lang="ts">
    import {toggleWideMenu, menuWideStore, PLAYERSBUTTONS, PLAYERS, VEHICLES, selectedPlayer} from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'
    import { fade } from 'svelte/transition';
    import { createEventDispatcher } from 'svelte';
    let visible = false;
    const dispatch = createEventDispatcher();


    const started = Array().fill(false);

    let searchTerm = '';

    function SelectPlayer(player) {
        selectedPlayer.set(player);

        if (!$menuWideStore.isMenuWide) {
            toggleWideMenu();
        }
    }

    function clickHandler() {
		visible = !visible
	}
    let time = null
    let reason = ''

    let selected;
    function selectOption(option) {
        selected = option;
        dispatch('optionSelected', option);
    }
</script>

<div class="w-[39vh] h-full flex flex-col items-center font-medium">
    <!-- SEARCH -->
    <div class="flex items-center gap-[1vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <i class="fas fa-magnifying-glass ml-[1.5vh]"></i>
        <input type="text" placeholder="Search" bind:value={searchTerm} class="w-[85%] h-full bg-transparent">
    </div>
    <!-- PLAYERS -->
    <div class="w-full h-[84vh] flex flex-col items-center overflow-auto">
        {#if $PLAYERS && $PLAYERSBUTTONS}
            {#each $PLAYERS.filter(player => player.name.toLowerCase().includes(searchTerm.toLowerCase()) || (player.id.includes(searchTerm.toLowerCase()))) as player, i}
                <button class="w-[95%] mt-[1vh] min-h-[4vh] p-[1vh] text-[1.6vh] text-start flex bg-primary"
                    on:click={() => { SelectPlayer(player) }}
                >
                    <div class="w-[96%]">
                        {player.id} - {player.name}
                    </div>
                    {#if !$menuWideStore.isMenuWide}
                        <div>
                            <i class="fas fa-angle-right"></i>
                        </div>
                    {/if}
                </button>
            {/each}
        {/if}
    </div>
</div>
