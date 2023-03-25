<script lang="ts">
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { browserMode, resName } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import Navbar from '@components/Navbar.svelte'

	$resName = 'ps-adminmenu'
</script>

<VisibilityProvider>
	<Navbar />
</VisibilityProvider>

<AlwaysListener />
{#if $browserMode}
	<DebugBrowser />
{/if}
