<script>
        import {toggleWideMenu, menuWideStore } from '@store/stores';
        let reportchat = false;
</script>


<div class="w-full h-full flex flex-row">
    <div>
        <!-- SearchBar -->
        <div class="h-[7.5rem] w-full border-b-2 border-tertiary flex items-center justify-center"> 
            <input class="ml-8 mt-2 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search">
            <button class="fa-solid fa-magnifying-glass fa-xl hover:bg-tertiary h-full w-40"></button>
        </div>
        <!-- Report List -->
        <div class="w-full h-[88.5%] flex items-center flex-col overflow-auto">
            <button on:click={toggleWideMenu} class="mt-2 w-[94%] h-[8rem] bg-primary text-start px-4 flex items-center hover:bg-tertiary">
                <div>
                    <p class="font-medium text-[2.2rem]">Report: 52</p>
                    <p class="font-medium text-[1.4rem]">Reason: A person killed me</p>
                </div>
                <div class="flex justify-center items-center flex-row-reverse ml-auto mr-4">
                    <i class="fas fa-angle-right fa-lg"></i>
                </div>
            </button>

        </div>
    </div>
    {#if $menuWideStore.isMenuWide}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col">
            <!-- Report Chat Header  -->
            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[2.2rem]"> Report 52</div>
            <!-- Report Chat Container  -->
            {#if reportchat}
                <div class="w-full flex-grow overflow-auto">
                </div>
            {:else}
                <div class="w-full h-full flex items-center justify-center flex-col">
                    <img class="w-[18rem] opacity-50" src="https://i.imgur.com/CJXACFN.png" alt="">
                    <p class="mb-[10rem] mt-8 text-tertiary text-[2.5rem] font-bold w-[26rem] text-center opacity-50">You have not selected any report!</p>
                </div>
            {/if}
            <!-- Report Chat Input Box  -->
            <div class="w-full h-[6.5rem] bg-primary mt-auto flex items-center"> 
                <button class="fas fa-folder-plus fa-lg bg-tertiary w-[6rem] h-full hover:bg-accent"></button>
                <input placeholder="Type your message here..." type="text" class="h-[6.5rem] w-[59rem] ml-6 font-medium bg-transparent">
                <button class="fas fa-paper-plane fa-lg ml-auto bg-tertiary w-[12rem] h-full hover:bg-accent"></button>
            </div>
        </div>
    {/if}
</div>
