<script>
    import {toggleWideMenu, menuWideStore, RESOURCESBUTTONS, RESOURCES} from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'

    const started = Array().fill(false);

    let searchTerm = '';
</script>

<div class="w-[39vh] h-full flex flex-col items-center font-medium">
    <!-- SEARCH -->
    <div class="flex items-center gap-[1vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <i class="fas fa-magnifying-glass ml-[1.5vh]"></i>
        <input type="text" placeholder="Search" bind:value={searchTerm} class="w-[85%] h-full bg-transparent">
    </div>
    <!-- RESOURCES -->
    <div class="w-full h-[84vh] flex flex-col items-center overflow-auto">
        {#if $RESOURCESBUTTONS && $RESOURCES}
            {#each $RESOURCES.filter(resource => resource.name.toLowerCase().includes(searchTerm.toLowerCase()) || (resource.author && resource.author.toLowerCase().includes(searchTerm.toLowerCase()))) as resource, i}
                <div class="w-[95%] mt-[1vh] p-[1vh] text-[1.6vh] bg-primary">
                    <div class="w-full flex justify-between">
                        <div class="text-[2.5vh]">{resource.name}</div>
                        <div class="flex gap-[1vh]">
                            {#if resource.resourceState === "started"}
                            <button class="w-[3vh] h-[3vh] rounded-lg border border-yellow-400 text-yellow-400 hover:text-white hover:bg-yellow-400"
                                on:click={() => { SendNUI('ChangeResourcesState', { name: resource.name, state: "restart" });}} >
                                <i class="fas fa-arrows-rotate"></i>
                            </button>
                            <button class="w-[3vh] h-[3vh] rounded-lg border border-red-400 text-red-400 hover:text-white hover:bg-red-400"
                                on:click={() => { SendNUI('ChangeResourcesState', { name: resource.name, state: "stopped" });}} >
                                <i class="fas fa-stop"></i>
                            </button>
                            {:else}
                            <button class="w-[3vh] h-[3vh] rounded-lg border border-green-400 text-green-400 hover:text-white hover:bg-green-400"
                                on:click={() => { SendNUI('ChangeResourcesState', { name: resource.name, state: "started" });}} >
                                <i class="fas fa-play"></i>
                            </button>
                            {/if}
                        </div>
                    </div>
                    <div>{resource.description}</div>
                    <div>{resource.author}</div>
                    <div>{resource.version}</div>
                    <div>{resource.resourceState}</div>
                </div>
            {/each}
        {/if}
    </div>
</div>
