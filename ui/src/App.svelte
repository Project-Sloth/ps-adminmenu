<script lang="ts">
	import VisibilityProvider from '@providers/VisibilityProvider.svelte'
	import { BROWSER_MODE, RESOURCE_NAME } from '@store/stores'
	import DebugBrowser from '@providers/DebugBrowser.svelte'
	import AlwaysListener from '@providers/AlwaysListener.svelte'
	import Main from './layout/Main.svelte'
	import VehicleDev from '@components/VehicleDev.svelte'
	import { VEHICLE_DEV } from '@store/vehicle_dev'
	import ToggleCoords from '@components/ToggleCoords.svelte'
	import { TOGGLE_COORDS } from '@store/togglecoords'
	import { ENTITY_INFO } from '@store/entityInfo'
	import EntityInformation from '@components/EntityInformation.svelte'


	$RESOURCE_NAME = 'ps-adminmenu'
</script>

<VisibilityProvider>
	<Main />
</VisibilityProvider>

{#if $VEHICLE_DEV?.show}
	<VehicleDev />
{/if}

{#if $TOGGLE_COORDS?.show}
	<ToggleCoords />
{/if}

{#if $ENTITY_INFO?.show}
	<EntityInformation />
{/if}

<AlwaysListener />
{#if $BROWSER_MODE}
	<DebugBrowser />
	<div class="absolute w-screen h-screen bg-neutral-800" />
{/if}
