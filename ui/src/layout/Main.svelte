<script>
    import { menuWideStore, currentPage  } from '@store/stores';
    import Sidebar from './Sidebar.svelte'
    import { fly } from 'svelte/transition';
	import Actions from '@pages/actions/Actions.svelte'
	import Players from '@pages/players/Players.svelte'
	import Server from '@pages/server/Server.svelte'
	import Chat from '@pages/staffchat/Chat.svelte'
</script>

<div class="w-full h-full flex items-center {$menuWideStore.isMenuWide ? "justify-center" : " justify-end"}" transition:fly={{ x: 200 }}>
    <div class="bg-secondary mr-[3vh] h-[90vh] flex {$menuWideStore.isMenuWide ? 'w-[120vh]' : 'w-[45vh]'}">
        <Sidebar />
        <div class="h-full">
            {#if $currentPage === "actions"}
                <Actions />
            {:else if $currentPage === "players"}
                <Players />
            {:else if $currentPage === "server"}
                <Server />
            {:else if $currentPage === "staffchat"}
                <Chat />
            {/if}
        </div>
    </div>
</div>
