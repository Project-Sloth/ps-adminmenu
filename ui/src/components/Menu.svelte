<script>
  import { fly, slide } from 'svelte/transition';
  import { quintOut } from 'svelte/easing';
  import { menuWideStore, currentPage  } from '@store/stores';
  import Actions from "./Pages/Actions/Actions.svelte";
  import Settings from "./Pages/Settings/Settings.svelte";
  import Sidebar from "./Sidebar.svelte";
	import Reports from './Pages/Report/Reports.svelte'
	import Server from './Pages/Server/Server.svelte'

</script>
  
<!-- Menu -->
<div class="h-screen flex items-center transition-all {($menuWideStore.isMenuWide ? 'w-[125rem] mx-auto' : 'w-[45rem]  float-right')}" 
transition:fly="{{delay: 250, duration: 300, x: 500}}">
  <!-- Sidebar -->
  <Sidebar />
  <!-- Pages -->
  <div class="mr-8 h-[100rem] bg-secondary  {($menuWideStore.isMenuWide  ? 'w-[120rem]' : 'w-[40rem]')}" >
    {#if $currentPage === "actions"}
      <Actions />
    {:else if $currentPage === "settings"}
      <Settings />
    {:else if $currentPage === "reports"}
      <Reports />
    {:else if $currentPage === "server"}
      <Server />
    {/if}
  </div>
</div>

  