<script>
    import {toggleWideMenu, menuWideStore, currentPage, toggleDevMode, devmodeStore } from '@store/stores';

</script>

<div class="w-[6vh] h-full bg-primary pb-[4vh] text-[2vh] flex flex-col-reverse ">
    <!-- ACTIONS -->
    <button class="w-full h-[5.5vh] hover:bg-tertiary hover:text-accent {$currentPage === 'actions' ? " bg-tertiary text-accent" : ""}"
        on:click={() => currentPage.set('actions')}
    >
        <i class="fas fa-hat-wizard"></i>
    </button>
    <!-- SERVER -->
    <button class="w-full h-[5.5vh] hover:bg-tertiary hover:text-accent {$currentPage === 'server' ? " bg-tertiary text-accent" : ""}"
        on:click={() => currentPage.set('server')}
    >
        <i class="fas fa-server"></i>
    </button>
    <!-- PLAYERS -->
    <button class="w-full h-[5.5vh] hover:bg-tertiary hover:text-accent {$currentPage === 'players' ? " bg-tertiary text-accent" : ""}"
        on:click={() => currentPage.set('players')}
    >
        <i class="fas fa-users"></i>
    </button>
    <!-- STAFFCHAT -->
    <button class="w-full h-[5.5vh] hover:bg-tertiary hover:text-accent {$currentPage === 'staffchat' ? " bg-tertiary text-accent" : ""}"
        on:click={() => currentPage.set('staffchat')}
    >
        <i class="fas fa-comments"></i>
    </button>
    <!-- METRICS
    <button class="w-full h-[5.5vh] hover:bg-tertiary hover:text-accent {$currentPage === 'metrics' ? " bg-tertiary text-accent" : ""}"
        on:click={() => currentPage.set('metrics')}
    >
        <i class="fas fa-server"></i>
    </button> -->
    <!-- WIDE MENU -->
    <button class="w-full h-[5.5vh] mb-auto hover:bg-tertiary hover:text-accent"
    on:click={toggleWideMenu}
    >
        <i class="fas fa-{$menuWideStore.isMenuWide ? 'angle-right' : 'angle-left'}"></i>
    </button>
</div>

