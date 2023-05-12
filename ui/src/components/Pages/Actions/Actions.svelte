<script lang="ts">
    import Autocomplete from '@components/components/Autocomplete.svelte'
    import { ACTIONSBUTTONS, ACTIONS, menuWideStore } from '@store/stores'
    import { SendNUI } from '@utils/SendNUI'
    import { fly } from 'svelte/transition';

    const dropdownActive = Array(ACTIONS.length).fill(false);

    function ToggleDropdown(index: number) {
        dropdownActive[index] = !dropdownActive[index];
    }

</script>

<div class="w-full h-full flex flex-col">
    <!-- Tabs -->
    <div class="w-full h-[5.5rem] flex"> 
        <button class="w-[6rem] h-full hover:bg-tertiary font-medium">All</button>
        <button class="w-[10rem] h-full hover:bg-tertiary font-medium">Favourites</button>
    </div>
    <!-- SearchBar -->
    <div class="h-[5.5rem] w-full border-b-2 border-tertiary flex items-center justify-center"> 
        <input class="ml-8 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search">
    </div>
    <!-- Button List -->
    <div class="w-full h-[88.5%] flex items-center flex-col overflow-auto ">
        {#if $ACTIONSBUTTONS && $ACTIONS}
        {#each $ACTIONS.sort((a, b) => a.label.localeCompare(b.label)) as button, i}
                {#if button.dropdown}
                    <!-- Dropdown Buttons -->
                    <button 
                        on:click={() => ToggleDropdown(i)}
                        class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                        <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far')} fa-star fa-lg "></i>
                        <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                        <i class="fa fa-angle-right fa-lg ml-auto"></i>
                    </button>
                    {#if dropdownActive[i]}
                    <div transition:fly="{{ y: -20, duration: 150 }}" class="bg-primary flex flex-col flex-wrap p-4 {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%] t')}">
                            <input class="bg-secondary p-3 w-[15rem] mt-2" type="text" placeholder="Input">
                            <input class="bg-secondary p-3 w-[15rem] mt-2" type="text" placeholder="Input">
                            <input class="bg-secondary p-3 w-[15rem] mt-2" type="text" placeholder="Input">
                            <button class="bg-secondary p-3 w-[15rem] mt-2"> Confirm</button>
                        </div>
                    {/if}
                {:else}
                <!-- Normal Buttons -->
                <button 						
                    on:click={() => {
                        SendNUI('normalButton', { event: button.event, type: button.type });
                    }}
                    class="bg-primary flex px-[1.5rem] py-[1.2rem] mt-2 flex-row items-center {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%]')}">
                    <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far')} fa-star fa-lg "></i>
                    <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                </button>
                {/if}
            {/each}
        {/if}
    </div>
  
</div>
