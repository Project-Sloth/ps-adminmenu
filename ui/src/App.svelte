<script lang="ts">
	import Menu from '@components/Menu.svelte'
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { browserMode, resName } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import './main.css';

	$resName = 'ps-adminmenu' // Change this to your resource name (case sensitive)
</script>

<VisibilityProvider>
	<Menu />
</VisibilityProvider>


<AlwaysListener />
{#if $browserMode}
	<DebugBrowser />
{/if}
