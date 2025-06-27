<script lang="ts">
	import { MENU_WIDE, searchActions } from '@store/stores'
	import { ACTION, ALL_ACTIONS } from '@store/actions'

	import Header from '@components/Header.svelte'
	import Tabs from './components/Tabs.svelte'
	import Button from './components/Button.svelte'
	import Dropdown from './components/Dropdown.svelte'
	import ButtonState from '@pages/Server/components/ButtonState.svelte'

</script>

<div class="h-full w-[99vh] px-[2vh]">
	<Header 
		title={'Actions'} 
		hasSearch={true} 
		hasLargeMenu={true} 
		onSearchInput={event => $searchActions = event.target.value}
		search={$searchActions}
	/>
	<Tabs />
	<div class="w-full h-[77%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto scroll-visble">
		{#if $ACTION}
			{#each Object.entries($ACTION)
			.filter(([actionKey, actionValue]) => {
				if ($ALL_ACTIONS) {
					return actionValue.label.toLowerCase().includes($searchActions.toLowerCase());
				} else {
					return localStorage.getItem(`favorite-${actionKey}`) === 'true';
				}
			})
			.sort(([aKey, aValue], [bKey, bValue]) =>
				aValue.label.localeCompare(bValue.label)
			) as [actionKey, actionValue]}
				{#if actionValue.dropdown}
					<Dropdown data={actionValue} id={actionKey} />
				{:else}
					<Button data={actionValue} id={actionKey} />
				{/if}
			{/each}
		{/if}
	</div>
</div>
