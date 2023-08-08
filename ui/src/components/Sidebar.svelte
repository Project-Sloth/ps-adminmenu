<script>
    import {toggleWideMenu, menuWideStore, currentPage, toggleDevMode, devmodeStore } from '@store/stores';

</script>

<div class="w-[6rem] h-[91%] bg-primary float-right">
    <div class="w-[6rem] h-full flex flex-col-reverse">
        <!-- <button on:click={() => currentPage.set('settings')} class="w-full h-[5.5rem] hover:bg-secondary mb-16 {($currentPage === 'settings' ? 'bg-tertiary text-accent' : '')}"><i class="fas fa-gear fa-lg"></i></button> -->
        <!-- <button on:click={toggleDevMode} class="w-full h-[5.5rem] hover:bg-secondary {$devmodeStore.isDevmode ? '' : ' text-accent'}"><i class="fas fa-terminal fa-lg"></i></button> -->
        <button data-tooltip='Actions' on:click={() => currentPage.set('actions')} class="w-full h-[5.5rem] hover:bg-secondary mb-16 {($currentPage === 'actions' ? 'bg-tertiary text-accent' : '')}"><i class="fas fa-hat-wizard fa-lg"></i></button>
        <button data-tooltip='Resources' on:click={() => currentPage.set('server')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'server' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-server fa-lg"></i></button>
        <!-- <button on:click={() => currentPage.set('reports')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'reports' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-comments fa-lg"></i></button> -->
        <button data-tooltip='Online Players' on:click={() => currentPage.set('players')} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'players' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-users fa-lg"></i></button>
        <button data-tooltip='Staffchat' on:click={() => {toggleWideMenu; currentPage.set('staffchat')}} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'staffchat' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-crown fa-lg"></i></button>
        <button data-tooltip='Server Metrics' on:click={() => {toggleWideMenu; currentPage.set('metrics')}} class="w-full h-[5.5rem] hover:bg-secondary {($currentPage === 'metrics' ? ' bg-tertiary text-accent' : '')}"><i class="fas fa-info fa-lg"></i></button>
        <button data-tooltip='Open Wide Menu' on:click={toggleWideMenu} class="w-full h-[5.5rem] hover:bg-tertiary mb-auto"> <i class="fas fa-{$menuWideStore.isMenuWide ? 'angle-right' : 'angle-left'} fa-lg"></i></button>
    </div>
</div>
<style>
[data-tooltip] {
  position: relative;
  z-index: 9999;
  display: block;
}

[data-tooltip]:before,
[data-tooltip]:after {
  visibility: hidden;
  opacity: 0;
  pointer-events: none;
	transition: .2s ease-out;
	transform: translate(-50%, 5px)
}

[data-tooltip]:before {
  position: absolute;
  bottom: 50%;
  left: 100%;
  margin-bottom: 5px;
  padding: 7px;
	width: 100%;
  min-width: 70px;
	max-width: 250px;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
  background-color: #000;
  background-color: hsla(0, 0%, 20%, 0.9);
  color: #fff;
  content: attr(data-tooltip);
  text-align: center;
  font-size: 14px;
  line-height: 1.2;
	transition: .2s ease-out
}

[data-tooltip]:after {
position: absolute;
  bottom: 50%;
  left: 100%;
  width: 0;
  content: " ";
  font-size: 0;
  line-height: 0;
}

[data-tooltip]:hover:before,
[data-tooltip]:hover:after {
  visibility: visible;
  opacity: 1;
	transform: translate(-50%, 0)
}
</style>
