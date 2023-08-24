<script>
	import { MENU_WIDE } from '@store/stores'
	import { RESOURCE } from '@store/server'

	import Header from '@components/Header.svelte'
	import ResourceCard from './components/ResourceCard.svelte'

	let search = ''
	
	let SortedResources = $RESOURCE ? $RESOURCE.slice().sort((a, b) => a.name.localeCompare(b.name)) : []
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header 
		title={'Server'} 
		hasSearch={true} 
		onSearchInput={event => (search = event.target.value)} 
	/>
	<div class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto">
		{#if $RESOURCE}
			{#if $RESOURCE && $RESOURCE.filter((resource) => resource.name.toLowerCase().includes(search.toLowerCase())).length === 0}
				<div class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]">No Resource Found.</div>
			{:else}
				{#each SortedResources.filter((resource) => resource.name.toLowerCase().includes(search.toLowerCase())) as resource}
					<ResourceCard
						label={resource.name}
						version={resource.version}
						author={resource.author}
						description={resource.description}
						state={resource.resourceState}
					/>
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
