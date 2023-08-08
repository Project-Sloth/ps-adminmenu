<script>
    import {toggleWideMenu, menuWideStore, PLAYERS, PLAYERSBUTTONS} from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'

    const started = Array().fill(false);

    let searchTerm = '';
</script>

<div class="w-[39vh] h-full flex flex-col items-center font-medium">
    <!-- SEARCH -->
    <div class="flex items-center gap-[1vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <i class="fas fa-magnifying-glass ml-[1.5vh]"></i>
        <input type="text" placeholder="Search" class="w-[85%] h-full bg-transparent">
    </div>
    <!-- PLAYERS -->
    <div class="w-full h-[84vh] flex flex-col items-center overflow-auto">
        {#if $PLAYERS && $PLAYERSBUTTONS}
            {#each $PLAYERS.filter(resource => resource.name.toLowerCase().includes(searchTerm.toLowerCase()) || (resource.author && resource.author.toLowerCase().includes(searchTerm.toLowerCase()))) as resource, i}
                <button class="w-[95%] mt-[1vh] min-h-[4vh] p-[1vh] text-[1.6vh] text-start bg-primary">
                    <div>{resource.name}</div>
                </button>
            {/each}
        {/if}
    </div>
</div>
