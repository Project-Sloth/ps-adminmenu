<script>
	import { MENU_WIDE } from '@store/stores'
	import { COMMANDS } from '@store/server'

	import Header from '@components/Header.svelte'
	import CommandsCard from './components/CommandsCard.svelte'

	let search = ''

	let SortedCommands = $COMMANDS ? $COMMANDS.slice().sort((a, b) => a.name.localeCompare(b.name)) : []
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header
		title={'Commands'}
		hasSearch={true}
		onSearchInput={event => (search = event.target.value)}
	/>
	<div class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto">
		{#if $COMMANDS}
			{#if $COMMANDS && $COMMANDS.filter((commands) => commands.name.toLowerCase().includes(search.toLowerCase())).length === 0}
				<div class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]">No Commands Found.</div>
			{:else}
				<small class="font-medium">Total Commands: {SortedCommands.length}</small>
				{#each SortedCommands.filter((commands) => commands.name.toLowerCase().includes(search.toLowerCase())) as commands}
					<CommandsCard label={commands.name} />
				{/each}
			{/if}
		{/if}
	</div>
</div>

{#if $MENU_WIDE}
	<div class="h-full w-[66vh] border-l-[0.2vh] border-tertiary px-[2vh]">
		<Header title={'Dashboard'} />
	</div>
{/if}
