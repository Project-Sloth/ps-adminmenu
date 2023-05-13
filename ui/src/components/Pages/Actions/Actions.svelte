<script lang="ts">
    import Autocomplete from '@components/components/Autocomplete.svelte'
    import { ACTIONSBUTTONS, ACTIONS, menuWideStore } from '@store/stores'
    import { SendNUI } from '@utils/SendNUI'
    import { fly } from 'svelte/transition';

    const dropdownActive = Array(ACTIONS.length).fill(false);

    function ToggleDropdown(index: number) {
        dropdownActive[index] = !dropdownActive[index];
    }
    let showFavorites = false;
    let searchTerm = '';


</script>

<div class="w-full h-full flex flex-col">
    <!-- Tabs -->
    <div class="w-full h-[5.5rem] flex"> 
        <button class="w-[6rem] h-full hover:bg-tertiary font-medium" on:click={() => (showFavorites = !showFavorites)} >All</button>
        <button class="w-[10rem] h-full hover:bg-tertiary font-medium" on:click={() => (showFavorites = !showFavorites)} >Favorites</button>      
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
                        <i on:click={() => button.favorited = !button.favorited} class="{(button.favorited ? 'fas text-accent' : 'far')} fa-star fa-lg "></i>
                        <p class="ml-6 text-[2rem] font-medium">{button.label}</p>
                        <i class="fa fa-{(dropdownActive[i] ? 'angle-down' : 'angle-right')} fa-lg ml-auto"></i>
                    </button>
                    {#if dropdownActive[i]}
                    <div transition:fly="{{ y: -20, duration: 150 }}" class="bg-primary flex flex-col flex-wrap p-4 {($menuWideStore.isMenuWide ? 'w-[98%] ' : 'w-[94%] t')}">
                      {#each button.dropdown as dropdownItem}
                        {#if dropdownItem.type === 'input'}
                            <p class="font-medium mt-2">{dropdownItem.label}:</p>
                            <input class="bg-secondary p-3 w-[25rem] mt-1 font-medium  hover:bg-tertiary" type="text" placeholder="{dropdownItem.label}">
                        {:else if dropdownItem.type === 'button'}
                            <button                     
                            on:click={() => {
                                SendNUI('normalButton', { event: dropdownItem.event, type: dropdownItem.type });
                            }} 
                            class="bg-secondary p-3 w-[15rem] mt-2 font-medium hover:bg-tertiary">{dropdownItem.label}</button>
                        {/if}
                      {/each}
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
