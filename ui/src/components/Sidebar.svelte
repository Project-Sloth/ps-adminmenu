<script>
    import {toggleWideMenu, menuWideStore, currentPage } from '@store/stores';

</script>

<div class="w-[6rem] h-[100rem] bg-primary float-right">
    <div class="w-full h-full flex flex-col-reverse">
        <button on:click={() => currentPage.set('settings')} class="w-full h-[5.5rem] hover:bg-secondary mb-16 {($currentPage === 'settings' ? 'bg-tertiary text-accent' : '')}"><i class="fas fa-gear fa-lg"></i></button>
        <button on:click={() => currentPage.set('actions')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'actions' ? 'bg-tertiary text-accent' : '')}"><i class="fas fa-hat-wizard fa-lg"></i></button>
        <button on:click={() => currentPage.set('server')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'server' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-server fa-lg"></i></button>
        <button on:click={() => currentPage.set('reports')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'reports' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-comments fa-lg"></i></button>
        <button on:click={toggleWideMenu} class="w-full h-[5.5rem] hover:bg-tertiary mb-auto"> <i class="fas fa-{$menuWideStore.isMenuWide ? 'angle-right' : 'angle-left'} fa-lg"></i></button>
    </div>
</div>