<script lang="ts">
	import { MENU_WIDE } from '@store/stores'
	import { PLAYER, PLAYER_VEHICLES, SELECTED_PLAYER } from '@store/players'

	import Header from '@components/Header.svelte'
	import Button from './components/Button.svelte'
	import { onMount } from 'svelte'
	import { SendNUI } from '@utils/SendNUI'
	import Spinner from '@components/Spinner.svelte'
	import Autofill from '@components/Autofill.svelte'
	import Modal from '@components/Modal.svelte'

	let search = ''
	let loading = false;

	onMount(async () => {
		loading = true;
		const players = await SendNUI("getPlayers");
		PLAYER.set(players);
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
			<div class="w-full h-[96.5%] pt-[2vh] flex flex-col gap-[1vh]">
				<p class="font-medium text-[1.7vh]">Quick Actions</p>
				<div class="w-full bg-tertiary flex rounded-[0.5vh]">
					<button
						class="h-[4.5vh] w-full rounded-l-[0.5vh] hover:bg-secondary"
					>
						<i class="fas fa-user-minus"></i>
					</button>
					<button
						class="h-[4.5vh] w-full hover:bg-secondary"
					>
						<i class="fas fa-ban"></i>
					</button>
					<button
						class="h-[4.5vh] w-full hover:bg-secondary"
					>
						<i class="fas fa-person-walking-arrow-right"></i>
					</button>
					<button
						class="h-[4.5vh] w-full hover:bg-secondary"
					>
						<i class="fas fa-person-walking-arrow-loop-left"></i>
					</button>
					<button
						class="h-[4.5vh] w-full hover:bg-secondary"
					>
						<i class="fas fa-heart-pulse"></i>
					</button>
					<button
						class="h-[4.5vh] w-full hover:bg-secondary"
					>
						<i class="fas fa-eye"></i>
					</button>
				</div>
				<div class="h-[90%] overflow-auto flex flex-col gap-[1vh]">
					<p class="font-medium text-[1.7vh]">Licenses</p>
					<div class="w-full bg-tertiary rounded-[0.5vh] p-[1.5vh] text-[1.5vh]">

						<p>{$SELECTED_PLAYER.discord.replace('discord:', 'Discord: ')}</p>
						<p>{$SELECTED_PLAYER.license.replace('license:', 'License: ')}</p>
						<p>{$SELECTED_PLAYER.fivem ? $SELECTED_PLAYER.fivem : ""}</p>

						<p>{$SELECTED_PLAYER.steam ? $SELECTED_PLAYER.steam : ""}</p>
					</div>
					<p class="font-medium text-[1.7vh]">Information</p>
					<div class="w-full bg-tertiary rounded-[0.5vh] p-[1.5vh] text-[1.5vh]">
						<p>CID: {$SELECTED_PLAYER.cid}</p>
						<p>Name: {$SELECTED_PLAYER.name}</p>
						<p>Job: {$SELECTED_PLAYER.job}</p>
						<p>Cash: ${$SELECTED_PLAYER.cash}</p>
						<p>Bank: ${$SELECTED_PLAYER.bank}</p>
						<p>Phone: {$SELECTED_PLAYER.phone}</p>
					</div>
					<p class="font-medium text-[1.7vh]">Vehicles</p>
					{#each $SELECTED_PLAYER.vehicles as vehicle}
						<div class="w-full bg-tertiary flex flex-row rounded-[0.5vh] p-[1.5vh] text-[1.5vh]">
							<div>
								<p class=" font-medium text-[1.7vh]">{vehicle.label}</p>
								<p>Plate: {vehicle.plate}</p>
							</div>
							<div class="ml-auto h-full flex items-center">
								<button class="bg-secondary px-[1vh] py-[0.5vh] rounded-[0.5vh] border border-primary">
									Spawn
								</button>
							</div>
						</div>
					{/each}
				</div>
			</div>
		{/if}
    </div>
{/if}
