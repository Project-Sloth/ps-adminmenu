<script lang="ts">
    import {toggleWideMenu, menuWideStore, PLAYERSBUTTONS, PLAYERS} from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'

    const started = Array().fill(false);

    let searchTerm = '';

    let selectedPlayer = null;

    function SelectPlayer(button) {
        selectedPlayer = button;

        if (!$menuWideStore.isMenuWide) {
            toggleWideMenu();
        }
    }


</script>

<div class="w-full h-full flex flex-row ">
    <div>
        <!-- Search Bar -->
        <div class="h-[7.5rem] w-full border-b-2 border-tertiary flex items-center justify-center"> 
            <input class="ml-8 mt-2 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search" bind:value={searchTerm}>
            <button on:click={ () => { SendNUI("RefreshResources") }} class="fa-solid fa-arrows-rotate fa-xl hover:bg-tertiary h-full w-40"></button>
        </div>
        <!-- Player List -->
        <div class="w-[37.3rem] h-[91.5%] flex items-center flex-col overflow-auto ">
            <!-- Players -->
            {#if $PLAYERSBUTTONS && $PLAYERS}
                {#each $PLAYERS.filter(button => button.name.toLowerCase().includes(searchTerm.toLowerCase()) || (button.author && button.author.toLowerCase().includes(searchTerm.toLowerCase()))) as button, i}
                    <button on:click={() => SelectPlayer(button)} class=" mt-2 w-[94%] min-h-[10rem] bg-primary text-start px-4 flex items-center hover:bg-tertiary">
                        <div>
                            <p class="font-medium text-[2.5rem] ml-3">{button.id} - {button.name}</p>

                            <p class="font-medium text-[1.4rem] ml-3 mt-1">Citizen ID: {button.cid ?? 'none'}</p>
                        </div>
                        <div class="flex justify-center items-center flex-row-reverse ml-auto mr-4">
                            <i class="fas fa-angle-right fa-lg"></i>
                        </div>
                    </button>
                {/each}
            {/if}
        </div>
    </div>

    {#if $menuWideStore.isMenuWide && selectedPlayer}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col">
            <!-- Report Chat Header  -->
            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[2.2rem]">
                {selectedPlayer.id} - {selectedPlayer.name} - {selectedPlayer.license}
            </div>

        </div>
    {:else if $menuWideStore.isMenuWide}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col">
            <!-- Report Chat Header  -->
            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[2.2rem]">
                Select a player
            </div>

            <div class="w-full h-full flex items-center justify-center flex-col">
                <img class="w-[18rem] opacity-50" src="https://i.imgur.com/CJXACFN.png" alt="">
                <p class="mb-[10rem] mt-8 text-tertiary text-[2.5rem] font-bold w-[26rem] text-center opacity-50">You have not selected a player!</p>
            </div>
        </div>
    {/if}

</div>

