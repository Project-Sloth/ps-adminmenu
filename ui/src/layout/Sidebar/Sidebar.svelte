<script>
	import { DEV_MODE, MENU_WIDE } from '@store/stores'
	import Button from './Components/Button.svelte'

	let navigation = [
		{ value: 'Staffchat', icon: 'fas fa-message' },
		{ value: 'Players', icon: 'fas fa-users' },
		{ value: 'Server', icon: 'fas fa-server' },
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
		<Button icon={nav.icon} value={nav.value} />
	{/each}

	<button
		class="w-[4vh] h-[4vh] rounded-[0.5vh] hover:bg-tertiary {$DEV_MODE ? "text-accent" : ""}"
		on:click={() => DEV_MODE.update((wide) => !wide)}
	>
		<i class="fas fa-code"></i>
	</button>
</div>
