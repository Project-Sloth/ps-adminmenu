<script>
	import DropdownComponent from '@components/DropdownComponent.svelte'
	import { SendNUI } from '@utils/SendNUI'
	import { slide } from 'svelte/transition'
	import Autofill from '@components/Autofill.svelte'
	import Favorite from './Favorite.svelte'
	import Input from './Input.svelte'

	export let data
	export let id

	let dropdownActive

	let selectedDataArray = {}

	function SelectData(selectedData) {
		// console.log('selected', selectedData)
		selectedDataArray[selectedData.id] = selectedData
	}

	function sendData(event, type) {
		if (event) {
			data.event = event
			data.type = type
		}
		// console.log('data', data)
		// console.log('event', data.event)
		// console.log('type', data.type)
		SendNUI('clickButton', {
			data: id,
			selectedData: selectedDataArray,
		})
		// console.log(selectedDataArray)
	}
</script>

<div
	class=" bg-tertiary rounded-[0.5vh] {dropdownActive
		? ''
		: 'hover:bg-opacity-90'}"
>
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
						<Input data={i} selectedData={SelectData} />
					{:else if i.option === 'dropdown'}
						<Autofill
							action={i}
							label_title={i.label}
							data={i.data}
							selectedData={SelectData}
						/>
					{:else if i.option === 'button'}
						<button
							class="h-[3.8vh] px-[1.5vh] rounded-[0.5vh] bg-secondary hover:bg-opacity-90 border-[0.1vh] border-primary"
							on:click={() => {
								sendData(i.event, i.type)
							}}
						>
							<p>{i.label}</p>
						</button>
					{/if}
				{/each}
			{/if}
		</div>
	{/if}
</div>
