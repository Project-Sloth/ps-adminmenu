<script lang="ts">
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { BROWSER_MODE, RESOURCE_NAME } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import Main from './layout/Main.svelte'
	import VehicleDev from '@components/VehicleDev.svelte'
	import { VEHICLE_DEV } from '@store/vehicle_dev'

	$RESOURCE_NAME = 'ok1ez-admin'
</script>

<VisibilityProvider>
	<Main />
</VisibilityProvider>

{#if $VEHICLE_DEV?.show}
	<VehicleDev />
{/if}

<AlwaysListener />
{#if $BROWSER_MODE}
	<DebugBrowser />
	<div class="absolute w-screen h-screen bg-neutral-800" />
{/if}