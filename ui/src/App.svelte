<script lang="ts">
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { browserMode, resName } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import Main from './layout/Main.svelte'

	$resName = 'ps-adminmenu' // Change this to your resource name (case sensitive)
</script>

<VisibilityProvider>
	<Main />
</VisibilityProvider>

<AlwaysListener />
{#if $browserMode}
	<DebugBrowser />
	<body style="background-color: rgb(33, 33, 33);"></body>
{/if}
