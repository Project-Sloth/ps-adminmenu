<script>
	import { ACTIVE_PAGE } from '@store/stores'

	export let icon
	export let value
	export let tooltiptext
</script>

<button
	title={tooltiptext}
	class="w-[4vh] h-[4vh] rounded-[0.5vh] hover:bg-tertiary {$ACTIVE_PAGE == value ? 'bg-tertiary' : ''}"
	on:click={() => {
		ACTIVE_PAGE.set(value)
	}}
>
	<i class={icon} />
</button>