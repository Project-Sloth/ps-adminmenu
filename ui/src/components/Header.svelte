<script>
	import { MENU_WIDE } from '@store/stores'

	export let title
	export let hasSearch = false
	export let hasLargeMenu = false
	export let onSearchInput = null
	export let search = null
</script>

<p class="my-[2vh] font-medium text-[2vh]">{title}</p>

{#if hasSearch}
	<div
		class="w-full h-[4.5vh] rounded-[0.5vh] flex items-center justify-center gap-[1vh] bg-tertiary"
	>
		<i class="fas fa-magnifying-glass text-[1.5vh]" />
		<input
			on:input={onSearchInput}
			bind:value={search}
			type="text"
			placeholder="Search"
			class="h-full px-[1vh] bg-transparent text-[1.7vh] {hasLargeMenu ? $MENU_WIDE ? 'w-[94%]' : 'w-[80%]' : 'w-[80%]'}"
		/>
	</div>
{/if}
