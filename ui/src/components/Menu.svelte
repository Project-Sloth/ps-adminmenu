<script>
  import { fly } from 'svelte/transition';
  import { menuWideStore, currentPage  } from '@store/stores';
  import Actions from "./Pages/Actions/Actions.svelte";
  import Settings from "./Pages/Settings/Settings.svelte";
  import Sidebar from "./Sidebar.svelte";
	import Reports from './Pages/Report/Reports.svelte'
	import Server from './Pages/Server/Server.svelte'
	import PlayerList from './Pages/PlayerList/PlayerList.svelte'
	import StaffChat from './Pages/StaffChat/StaffChat.svelte'
  import Metrics from './Pages/Metrics/Metrics.svelte'

</script>

<!-- Menu -->
<div class="h-screen flex items-center transition-all {($menuWideStore.isMenuWide ? 'w-[125rem] mx-auto' : 'w-[45rem]  float-right')}"
transition:fly="{{delay: 250, duration: 300, x: 500}}">
  <!-- Sidebar -->
  <Sidebar />
  <!-- Pages -->
  <div class="mr-8 h-[91%] bg-secondary  {($menuWideStore.isMenuWide  ? 'w-[100%]' : 'w-[100%]')}" >
    {#if $currentPage === "actions"}
      <Actions />
    {:else if $currentPage === "settings"}
      <Settings />
    {:else if $currentPage === "reports"}
      <Reports />
    {:else if $currentPage === "server"}
      <Server />
    {:else if $currentPage === "players"}
      <PlayerList />
    {:else if $currentPage === "staffchat"}
      <StaffChat />
    {:else if $currentPage === "metrics"}
      <Metrics />
    {/if}
  </div>
</div>

