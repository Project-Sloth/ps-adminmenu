<script lang="ts">
	import { MENU_WIDE } from '@store/stores'
	import { PLAYER, SELECTED_PLAYER } from '@store/players'

	import Header from '@components/Header.svelte'
	import Button from './components/Button.svelte'
	import { onMount } from 'svelte'
	import { SendNUI } from '@utils/SendNUI'
	import Spinner from '@components/Spinner.svelte'

	let search = ''
	let loading = false;

	onMount(async () => {
		loading = true;
		const data = await SendNUI("getPlayers");
		PLAYER.set(data);
		loading = false;
	});
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header 
		title={'Players'} 
		hasSearch={true} 
		onSearchInput={event => (search = event.target.value)} 
	/>
	<div class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto">
		{#if loading}
			<Spinner />
		{:else}
			{#if $PLAYER}
				{#if $PLAYER && $PLAYER.filter((player) => player.name.toLowerCase().includes(search.toLowerCase())).length === 0}
					<div class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]">No Player Found.</div>
				{:else}
					{#each $PLAYER.filter((player) => player.name.toLowerCase().includes(search.toLowerCase())) as player}
						<Button player={player} />
					{/each}
				{/if}
			{/if}
		{/if}
	</div>
</div>

{#if $MENU_WIDE}
    <div class="h-full w-[66vh] border-l-[0.2vh] border-tertiary p-[2vh]">
		{#if !$SELECTED_PLAYER}
			<div class="h-full w-full flex flex-col items-center justify-center">
				<div class="text-4xl text-tertiary">No Player Selected.</div>
			</div>
		{:else}
			<p class="text-[2vh] font-medium">ID: {$SELECTED_PLAYER.id} - {$SELECTED_PLAYER.name}</p>
		{/if}
    </div>
{/if}
