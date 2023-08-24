<script>
	import { slide } from 'svelte/transition'
	import ButtonState from './ButtonState.svelte'

	export let label
	export let version
	export let author
	export let description

	export let state

	let dropdownActive
</script>

<button
	class="w-full flex justify-between rounded-[0.5vh] bg-tertiary items-center"
	on:click={() => (dropdownActive = !dropdownActive)}
>
	<div class="h-full p-[2vh] -mr-[8vh] flex flex-col items-start text-start">
		<p class="text-[1.8vh] font-medium">{label ? label : ''}</p>
		<p class="text-gray-400">{version ? 'Version: ' + version : ''}</p>
		<p class="text-gray-400">{author ? 'Author: ' + author : ''}</p>
		{#if dropdownActive}
			<div transition:slide={{ duration: 150 }}>
				<p class="text-gray-400">{description ? description : ''}</p>
			</div>
		{/if}
	</div>

	<div class="flex gap-[1vh] h-full py-[1.8vh] pr-[1.8vh]">
		{#if state == 'started'}
			<ButtonState icon="fas fa-stop" resource={label} state={'stop'} />
			<ButtonState icon="fas fa-arrows-rotate" resource={label} state={'restart'} />
		{:else}
			<ButtonState icon="fas fa-play" resource={label} state={'start'} />
		{/if}
	</div>
</button>
