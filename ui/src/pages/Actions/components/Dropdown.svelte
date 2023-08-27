<script>
	import DropdownComponent from '@components/DropdownComponent.svelte'
	import { SendNUI } from '@utils/SendNUI'
	import { slide } from 'svelte/transition'
	import Autofill from '@components/Autofill.svelte'
	import Favorite from './Favorite.svelte'
	import { onMount } from 'svelte'

	export let data
	export let id

	let dropdownActive

	onMount(() => {
		// console.log("dropdown", data)
	})
</script>

<div class=" bg-tertiary rounded-[0.5vh] {dropdownActive ? "" : "hover:bg-opacity-90"}">
	<button
		class="w-full h-[4.5vh] flex items-center justify-between px-[1.5vh]"
		on:click={() => (dropdownActive = !dropdownActive)}
	>
		<div class="flex items-center gap-[1vh]">
			<Favorite data={id} />
			<p>{data.label}</p>
		</div>
		<i class="fas fa-angle-{dropdownActive ? 'down' : 'right'}" />
	</button>

	{#if dropdownActive}
		<div
			class="w-full rounded-b-[1vh] p-[1.5vh] flex flex-col gap-[1vh] justify-start items-start"
			transition:slide={{ duration: 150 }}
		>
			{#if data.dropdown}
				{#each data.dropdown as i}
					{#if i.option === 'text'}
					<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh] border-[0.1vh] border-primary">
						<div class="w-full h-[3.8vh] pl-[1vh] flex justify-between">
							<input 
								type="text" 
								placeholder={i.label} 
								class="h-full w-[90%] bg-transparent" 
							/>
						</div>
					</div>
					{:else if i.option === 'dropdown'}
						<Autofill 
							action={i} 
							label={i.label} 
							data={i.data} 
						/>
					{:else if i.option === 'button'}
						<button 
							class="h-[3.8vh] px-[1.5vh] rounded-[0.5vh] bg-secondary hover:bg-opacity-90 border-[0.1vh] border-primary"
							
						>
							<p>{i.label}</p>
						</button>
					{/if}
				{/each}
			{/if}
		</div>
	{/if}
</div>
