<script>
    import { debugData } from '../utils/debugData';

	let show = false;
    //EXAMPLE
    
    // debugData([
	// 	{
	// 		action: 'setVisible',
	// 		data: true,
	// 	},
	// ])

	let options = [
		{
			component: 'example',
			action: 'showEvent',
			data: {
				example: true
			},
			closeAction: 'hideEvent',
		},
	]
</script>

<!-- <div class="absolute top-0 left-0 z-[1000]">
	<button class="bg-red-500 text-white p-2"
		on:click={() => {
			show = !show;
		}}
	>
	Show
	</button>
	{#if show}
	<div class="w-fit h-fit bg-gray-600 p-2">
		{#each options as option}
		<div class="flex flex-row gap-2 items-center m-1">
			<p class="text-white">{option.component}</p>
			<button class="bg-red-500 text-white p-2"
				on:click={() => {
					debugData([
						{
							action: option.action,
							data: option.data,
						},
					])
				}}
			>
				Start
			</button>
			<button class="bg-red-500 text-white p-2"
				on:click={() => {
					debugData([
						{
							action: option.closeAction,
							data: option.data,
						},
					])
				}}
			>
				Close
			</button>
		</div>
		{/each}
	</div>
	{/if}
</div> -->