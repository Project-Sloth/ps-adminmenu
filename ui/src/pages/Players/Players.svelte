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
	import Input from '@pages/Actions/components/Input.svelte'

	let search = ''
	let loading = false
	let banPlayer = false
	let kickPlayer = false

	onMount(async () => {
		loading = true
		const players = await SendNUI('getPlayers')
		PLAYER.set(players)
		loading = false
	})

	let selectedDataArray = {}

	function SelectData(selectedData) {
		// console.log('selected', selectedData)
		selectedDataArray[selectedData.id] = selectedData
		// console.log('selectedDataArray', selectedDataArray)
	}

	let banData = [
		{ label: 'Permanent', value: '2147483647' },
		{ label: '10 Minutes', value: '600' },
		{ label: '30 Minutes', value: '1800' },
		{ label: '1 Hour', value: '3600' },
		{ label: '6 Hours', value: '21600' },
		{ label: '12 Hours', value: '43200' },
		{ label: '1 Day', value: '86400' },
		{ label: '3 Days', value: '259200' },
		{ label: '1 Week', value: '604800' },
		{ label: '3 Weeks', value: '1814400' },
	]
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header
		title={'Players'}
		hasSearch={true}
		onSearchInput={(event) => (search = event.target.value)}
	/>
	<div class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto">
		{#if loading}
			<Spinner />
		{:else if $PLAYER}
			{#if $PLAYER && $PLAYER.filter((player) => player.name
						.toLowerCase()
						.includes(search.toLowerCase())).length === 0}
				<div
					class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]"
				>
					No Player Found.
				</div>
			{:else}
				{#each $PLAYER.filter((player) => player.name
						.toLowerCase()
						.includes(search.toLowerCase())) as player}
					<Button {player} />
				{/each}
			{/if}
		{/if}
	</div>
</div>

{#if $MENU_WIDE}
	<div class="h-full w-[66vh] border-l-[0.2vh] border-tertiary p-[2vh]">
		{#if !$SELECTED_PLAYER}
			<div
				class="h-full w-full flex flex-col items-center justify-center"
			>
				<div class="text-4xl text-tertiary">No Player Selected.</div>
			</div>
		{:else}
			<p class="text-[2vh] font-medium">
				ID: {$SELECTED_PLAYER.id} - {$SELECTED_PLAYER.name}
			</p>
			<div class="w-full h-[96.5%] pt-[2vh] flex flex-col gap-[1vh]">
				<p class="font-medium text-[1.7vh]">Quick Actions</p>
				<div class="w-full bg-tertiary flex rounded-[0.5vh]">
					<button
						title="Kick Player"
						class="h-[4.5vh] w-full rounded-l-[0.5vh] hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Kick Player"
						on:click={() => (kickPlayer = true)}
					>
						<i class="fas fa-user-minus"></i>
					</button>
					<button
						title="Ban Player"
						class="h-[4.5vh] w-full hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Ban Player"
						on:click={() => (banPlayer = true)}
					>
						<i class="fas fa-ban"></i>
					</button>
					<button
						title="Teleport To Player"
						class="h-[4.5vh] w-full hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Teleport To Player"
						on:click={() =>
							SendNUI('clickButton', {
								data: 'teleportToPlayer',
								selectedData: {
									['Player']: {
										value: $SELECTED_PLAYER.id,
									},
								},
							})}
					>
						<i class="fas fa-person-walking-arrow-right"></i>
					</button>
					<button
						title="Bring Player"
						class="h-[4.5vh] w-full hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Bring Player"
						on:click={() =>
							SendNUI('clickButton', {
								data: 'bringPlayer',
								selectedData: {
									['Player']: {
										value: $SELECTED_PLAYER.id,
									},
								},
							})}
					>
						<i class="fas fa-person-walking-arrow-loop-left"></i>
					</button>
					<button
						title="Revive Player"
						class="h-[4.5vh] w-full hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Revive Player"
						on:click={() =>
							SendNUI('clickButton', {
								data: 'revivePlayer',
								selectedData: {
									['Player']: {
										value: $SELECTED_PLAYER.id,
									},
								},
							})}
					>
						<i class="fas fa-heart-pulse"></i>
					</button>
					<button
						title="Spectate Player"
						class="h-[4.5vh] w-full hover:bg-secondary
						relative
						before:content-[attr(data-tip)]
						before:absolute
						before:px-3 before:py-2
						before:left-1/2 before:-top-3
						before:w-max before:max-w-xs
						before:-translate-x-1/2 before:-translate-y-full
						before:bg-tertiary before:text-white
						before:rounded-md before:opacity-0
						before:translate-all

						after:absolute
						after:left-1/2 after:-top-3
						after:h-0 after:w-0
						after:-translate-x-1/2 after:border-8
						after:border-t-tertiary
						after:border-l-transparent
						after:border-b-transparent
						after:border-r-transparent
						after:opacity-0
						after:transition-all

						hover:before:opacity-100 hover:after:opacity-100
						"
						data-tip="Spectate Player"
						on:click={() =>
							SendNUI('clickButton', {
								data: 'spectate_player',
								selectedData: {
									['Player']: {
										value: $SELECTED_PLAYER.id,
									},
								},
							})}
					>
						<i class="fas fa-eye"></i>
					</button>
				</div>
				<div
					class="h-[90%] overflow-auto flex flex-col gap-[1vh] select-text"
				>
					<p class="font-medium text-[1.7vh]">Licenses</p>
					<div
						class="w-full bg-tertiary rounded-[0.5vh] p-[1.5vh] text-[1.5vh]"
					>
						<p>
							{$SELECTED_PLAYER.discord.replace(
								'discord:',
								'Discord: ',
							)}
						</p>
						<p>
							{$SELECTED_PLAYER.license.replace(
								'license:',
								'License: ',
							)}
						</p>
						<p>
							{$SELECTED_PLAYER.fivem
								? $SELECTED_PLAYER.fivem
								: ''}
						</p>

						<p>
							{$SELECTED_PLAYER.steam
								? $SELECTED_PLAYER.steam
								: ''}
						</p>
					</div>
					<p class="font-medium text-[1.7vh]">Information</p>
					<div
						class="w-full bg-tertiary rounded-[0.5vh] p-[1.5vh] text-[1.5vh]"
					>
						<p>CID: {$SELECTED_PLAYER.cid}</p>
						<p>Name: {$SELECTED_PLAYER.name}</p>
						<p>Job: {$SELECTED_PLAYER.job}</p>
						<p>Cash: ${$SELECTED_PLAYER.cash}</p>
						<p>Bank: ${$SELECTED_PLAYER.bank}</p>
						<p>Phone: {$SELECTED_PLAYER.phone}</p>
					</div>
					<p class="font-medium text-[1.7vh]">Vehicles</p>
					{#each $SELECTED_PLAYER.vehicles as vehicle}
						<div
							class="w-full bg-tertiary flex flex-row rounded-[0.5vh] p-[1.5vh] text-[1.5vh]"
						>
							<div>
								<p class=" font-medium text-[1.7vh]">
									{vehicle.label}
								</p>
								<p>Plate: {vehicle.plate}</p>
							</div>
							<div class="ml-auto h-full flex items-center">
								<button
									class="bg-secondary px-[1vh] py-[0.5vh] rounded-[0.5vh] border border-primary"
									on:click={() =>
										SendNUI('clickButton', {
											data: 'spawnPersonalVehicle',
											selectedData: {
												['VehiclePlate']: {
													value: vehicle.plate,
												},
											},
										})}
								>
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

{#if banPlayer}
	<Modal>
		<div class="flex justify-between">
			<p class="font-medium text-[1.8vh]">Ban {$SELECTED_PLAYER.name}</p>
			<button
				class="hover:text-accent"
				on:click={() => (banPlayer = false)}
			>
				<i class="fas fa-xmark"></i>
			</button>
		</div>
		<Input
			data={{
				label: 'Reason',
				value: 'reason',
				id: 'reason',
			}}
			selectedData={SelectData}
		/>
		<Autofill
			action={{
				label: 'Duration',
				value: 'duration',
				id: 'duration',
			}}
			label_title="Duration"
			data={banData}
			selectedData={SelectData}
		/>
		<button
			class="h-[3.8vh] px-[1.5vh] rounded-[0.5vh] bg-secondary hover:bg-opacity-90 border-[0.1vh] border-primary"
			on:click={() => {
				// console.log('Time: ', selectedDataArray['Duration'].value)
				// console.log('reason: ', selectedDataArray['Reason'].value)
				SendNUI('clickButton', {
					data: 'banPlayer',
					selectedData: {
						['Player']: {
							value: $SELECTED_PLAYER.id,
						},
						['Duration']: {
							value: selectedDataArray['Duration'].value,
						},
						['Reason']: {
							value: selectedDataArray['Reason'].value,
						},
					},
				})
			}}
		>
			<p>Ban</p>
		</button>
	</Modal>
{/if}

{#if kickPlayer}
	<Modal>
		<div class="flex justify-between">
			<p class="font-medium text-[1.8vh]">Kick {$SELECTED_PLAYER.name}</p>
			<button
				class="hover:text-accent"
				on:click={() => (kickPlayer = false)}
			>
				<i class="fas fa-xmark"></i>
			</button>
		</div>
		<Input
			data={{
				label: 'Reason',
				value: 'reason',
				id: 'reason',
			}}
			selectedData={SelectData}
		/>
		<button
			class="h-[3.8vh] px-[1.5vh] rounded-[0.5vh] bg-secondary hover:bg-opacity-90 border-[0.1vh] border-primary"
			on:click={() => {
				SendNUI('clickButton', {
					data: 'kickPlayer',
					selectedData: {
						['Player']: {
							value: $SELECTED_PLAYER.id,
						},
						['Reason']: {
							value: $SELECTED_PLAYER.id,
						},
					},
				})
			}}
		>
			<p>Kick</p>
		</button>
	</Modal>
{/if}
