<script>
	import { ALL_ACTIONS } from '@store/actions'
</script>

<div class="mt-[1vh] w-full h-[4.5vh] flex gap-[1vh] font-medium">
	<button
		class="w-full h-full hover:bg-tertiary border-[0.2vh] border-tertiary rounded-[0.5vh] {$ALL_ACTIONS ? 'bg-tertiary' : ''}"
		on:click={() => {
			ALL_ACTIONS.set(true)
			console.log($ALL_ACTIONS)
		}}
	>
		All Actions
	</button>
	<button
		class="w-full h-full hover:bg-tertiary border-[0.2vh] border-tertiary rounded-[0.5vh] {!$ALL_ACTIONS ? 'bg-tertiary' : ''}"
		on:click={() => {
			ALL_ACTIONS.set(false)
			console.log($ALL_ACTIONS)
		}}
	>
		Favorites
	</button>
</div>
