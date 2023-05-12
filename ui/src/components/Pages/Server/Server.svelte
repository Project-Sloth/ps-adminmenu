<script>
    import {toggleWideMenu, menuWideStore, RESOURCESBUTTONS, RESOURCES} from '@store/stores';

    let started = true;

    function toggleState() {
        started = !started
    }

</script>


<div class="w-full h-full flex flex-row">
<div>
    <!-- SearchBar -->
    <div class="h-[7.5rem] w-full border-b-2 border-tertiary flex items-center justify-center"> 
        <input class="ml-8 mt-2 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search">
        <button class="fa-solid fa-magnifying-glass fa-xl hover:bg-tertiary h-full w-40"></button>
    </div>
    <!-- Resource List -->
    <div class="w-full h-[92%] flex flex-col items-center overflow-auto">
        <!-- Resources -->
        {#if $RESOURCESBUTTONS && $RESOURCES}
            {#each $RESOURCES as button, i}
                <div class="mt-2 w-[94%] min-h-[15rem] bg-primary text-start px-4 flex flex-col">
                    <p class="font-medium text-[2.2rem] ml-3 mt-4">{button.name}</p>
                    <p class="font-medium text-[1.4rem] ml-3 mt-6">Version: {button.version}</p>
                    <p class="font-medium text-[1.4rem] ml-3">Author: {button.author}</p>
                    <p class="font-medium text-[1.4rem] ml-3">Description: {button.desc}</p>
                    <div class="ml-auto -mt-44">
                        {#if started}
                            <button class="mr-3 border border-yellow-400 p-2 px-4 text-yellow-400 hover:text-white hover:bg-yellow-400 rounded-lg"><i class="fa-solid fa-arrows-rotate"></i></button>
                            <button on:click={toggleState} class="mr-3 border border-red-500 p-2 px-4 text-red-400 hover:text-white hover:bg-red-500 rounded-lg"><i class="fa-solid fa-stop"></i></button>
                        {:else}
                            <button on:click={toggleState} class="mr-3 border border-green-400 p-2 px-4 text-green-400 hover:text-white hover:bg-green-400 rounded-lg"><i class="fa-solid fa-play"></i></button>
                        {/if}
                    </div>
                </div>
            {/each}
        {/if}
    
    </div>
</div>

    {#if $menuWideStore.isMenuWide}
        <div class="w-[80rem]  h-full border-l-2 border-tertiary flex flex-col items-center"> 
            <!-- Header  -->
            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-9 px-8 font-medium text-[2.2rem]"> 
                Server
            </div>

            <div class="w-[80%] h-full  p-9 px-8 font-medium text-[2.2rem]"> 
            
            </div>
        </div>
    {/if}


</div>
