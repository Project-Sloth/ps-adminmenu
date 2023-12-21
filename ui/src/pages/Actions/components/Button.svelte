<script>
	import { SendNUI } from '@utils/SendNUI'
	import Favorite from './Favorite.svelte'
	import { onMount } from 'svelte'

	export let data
	export let id

	onMount(() => {
		// console.log("button", data)
	})
</script>

<button
	class="min-h-[4.5vh] w-full flex items-center px-[1.5vh] rounded-[0.5vh] bg-tertiary hover:bg-opacity-90"
	on:click={() => {
		// console.log(data.event)
		SendNUI('clickButton', {
			data: id,
		})
	}}
>
	<div class="flex items-center gap-[1vh]">
		<Favorite data={id} />
		<p>{data.label}</p>
	</div>
</button>
