<script>
    import {toggleWideMenu, menuWideStore } from '@store/stores';
</script>


<div class="w-full h-full flex flex-row ">
<div>
    <!-- SearchBar -->
    <div class="h-[7.5rem] w-full border-b-2 border-tertiary flex items-center justify-center"> 
        <input class="ml-8 mt-2 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search">
        <button class="fa-solid fa-magnifying-glass fa-xl hover:bg-tertiary h-full w-40"></button>
    </div>
    <!-- Report List -->
    <div class="mt-2 w-[38rem] h-[72.5rem] overflow-auto">
        <button on:click={toggleWideMenu} class="mt-4 ml-3  w-[36.5rem] h-[8rem] bg-primary text-start px-4 flex items-center hover:bg-tertiary">
            <div>
                <p class="font-medium text-[2.2rem]">Personalization</p>
                <p class="text-[1.4rem]">Personalize you menu</p>
            </div>
            <div class="flex justify-center items-center flex-row-reverse ml-auto mr-4">
                <i class="fas fa-angle-right fa-lg"></i>
            </div>
        </button>

    </div>
</div>
{#if $menuWideStore.isMenuWide}
    <div class="w-full h-full border-l-2 border-tertiary"> 
        <!-- Report Chat Header  -->
        <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-9 px-8 font-medium text-[2.2rem]"> 
            

            
        </div>

    </div>
{/if}


</div>
