<script>
	import { DEV_MODE, MENU_WIDE } from '@store/stores'
	import Button from './Components/Button.svelte'
	import { SendNUI } from '@utils/SendNUI'

	let navigation = [
		{ value: 'Staffchat', icon: 'fas fa-message' },
		{ value: 'Players', icon: 'fas fa-users' },
		{ value: 'Server', icon: 'fas fa-server' },
		{ value: 'Commands', icon: 'fas fa-slash' },
		{ value: 'Actions', icon: 'fas fa-wand-magic-sparkles' },
	]
</script>

<div
	class="w-[7vh] h-full flex flex-col gap-y-[1vh] items-center py-[1.4vh] border-r-[0.2vh] border-tertiary"
>
	<div class="mb-auto">
		<button
			class="w-[4vh] h-[4vh] rounded-[0.5vh] hover:bg-tertiary"
			on:click={() => MENU_WIDE.update((wide) => !wide)}
		>
			<i
				class="fas"
				class:fa-angle-right={$MENU_WIDE}
				class:fa-angle-left={!$MENU_WIDE}
			/>
		</button>
	</div>

	{#each navigation as nav}
		<Button tooltiptext={nav.value} icon={nav.icon} value={nav.value} />
	{/each}

	<button
		class="w-[4vh] h-[4vh] rounded-[0.5vh] hover:bg-tertiary {$DEV_MODE
			? 'text-accent'
			: ''}
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
		data-tip="Dev Mode"
		on:click={() => {
			DEV_MODE.update((wide) => !wide)
			SendNUI('clickButton', {
				data: 'toggleDevmode',
			})
		}}
	>
		<i class="fas fa-code"></i>
	</button>
</div>
