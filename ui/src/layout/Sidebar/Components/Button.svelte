<script>
	import { ACTIVE_PAGE } from '@store/stores'

	export let icon
	export let value
	export let tooltiptext
</script>

<button
	title={tooltiptext}
	class="w-[4vh] h-[4vh] rounded-[0.5vh] hover:bg-tertiary {$ACTIVE_PAGE == value ? 'bg-tertiary' : ''}
		relative
		before:content-[attr(data-tip)]
		before:absolute
		before:-right-3 before:top-1/2
		before:w-max before:max-w-xs
		before:px-[1vh]
		before:py-[0.5vh]
		before:-translate-x-full before:-translate-y-1/2
		before:bg-tertiary before:text-white
		before:rounded-md before:opacity-0
		before:translate-all

		after:absolute
		after:-right-3 after:top-1/2
		after:-translate-x-0 after:-translate-y-1/2
		after:h-0 after:w-0
		after:border-t-transparent
		after:border-l-transparent
		after:border-b-transparent
		after:border-r-tertiary
		after:opacity-0
		after:transition-all

		hover:before:opacity-100 hover:after:opacity-100
		"
		data-tip={tooltiptext}
	on:click={() => {
		ACTIVE_PAGE.set(value)
	}}
>
	<i class={icon} />
</button>