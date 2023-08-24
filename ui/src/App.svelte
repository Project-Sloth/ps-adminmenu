<script lang="ts">
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { BROWSER_MODE, RESOURCE_NAME } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import Main from './layout/Main.svelte'

	$RESOURCE_NAME = 'ok1ez-admin'
</script>

<VisibilityProvider>
	<Main />
</VisibilityProvider>

<AlwaysListener />
{#if $BROWSER_MODE}
	<DebugBrowser />
	<div class="absolute w-screen h-screen bg-neutral-800" />
{/if}