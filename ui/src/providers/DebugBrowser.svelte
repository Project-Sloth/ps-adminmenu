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

	const debugActions = [
		{
			label: "Admin Car",
			type: "client",
			perms: "mod",
		},
		{
			label: "Ban Player",
			type: "client",
			perms: "mod",
			dropdown: [
				{ label: "Player ID", type: "input", inputtype: "normal" },
				{ label: "Reason", type: "input", inputtype: "normal" },
				{ label: "Copy Coords", type: "button", event: "ps-adminmenu:client:banplayer" },
				{ label: "Time", type: "input", inputtype: "normal" },
				{ label: "Ban", type: "button", event: "ps-adminmenu:client:banplayer" },

			],
		},
		{
			label: "Noclip",
			type: "client",
			perms: "mod",
		},
		{
			label: "Invisible",
			type: "client",
			perms: "mod",
		},
		{
			label: "Kick Player",
			type: "client",
			perms: "mod",
			dropdown: [
				{ label: "label", type: "input", inputtype: "normal" },
				{ label: "Ban", type: "button", event: "ps-adminmenu:client:banplayer" },
			],
		},
		{
			label: "Spawn Vehicle",
			type: "client",
			perms: "mod",
			dropdown: [
				{ label: "label", type: "input", inputtype: "normal" },
				{ label: "Ban", type: "button", event: "ps-adminmenu:client:banplayer" },
			],
		},
	]

	const debugResources = [
		{
			name: "ps-adminmenu",
			version: "1.0.0",
			desc: "A cool admin menu",
			author: "Project Sloth",
		},
		{
			name: "ps-mdt",
			version: "1.0.0",
			desc: "A cool mdt",
			author: "Project Sloth",
		},
		{
			name: "ps-dispatch",
			version: "1.0.0",
			desc: "A cool dispatch",
			author: "Project Sloth",
		},
		{
			name: "ps-hosuing",
			version: "1.0.0",
			desc: "A cool house",
			author: "Project Sloth",
		},
		{
			name: "ps-camera",
			version: "1.0.0",
			desc: "A cool camera",
			author: "Project Sloth",
		},
		{
			name: "ps-hud",
			version: "1.0.0",
			desc: "A cool hud",
			author: "Project Sloth",
		},
		{
			name: "ps-fuel",
			version: "1.0.0",
			desc: "A cool gas pump",
			author: "Project Sloth",
		},
		{
			name: "ps-liveries",
			version: "1.0.0",
			desc: "A cool liverie",
			author: "Project Sloth",
		},
		{
			name: "ps-ui",
			version: "1.0.0",
			desc: "A cool ui",
			author: "Project Sloth",
		},
	]

	let options = [
		{
				component: 'Show',
				actions : [
					{
						name: "show",
						action: "setVisible",
						data: true,
					},
					{
						name: "hide",
						action: "setVisible",
						data: false,
					},
				]
		},
		{
			component: 'Actions Data',
			actions : [
				{
					name: "Set Data",
					action: "setActionData",
					data: debugActions,
				},
			]
		},
		{
			component: 'Resource Data',
			actions : [
				{
					name: "Set Data",
					action: "setResourceData",
					data: debugResources,
				},
			]
		},
		// {
		// 	component: 'Example',
		// 	actions : [
		// 		{
		// 			name: "debugLocation",
		// 			custom: true,
		// 			customFunction: () => {
					// CUSTOM LOGIC
		// 			}
		// 		},
		// 		{
		// 			name: "toggle Show",
		// 			custom: true,
		// 			customFunction: () => {
					// CUSTOM LOGIC
		// 			}
		// 		},
		// 	]
		// },

	]
</script>


<div class="absolute top-0 z-[1000]">
	<button class="bg-[#232B33] text-white p-2 font-medium"
		on:click={() => {
			show = !show;
		}}
	>
	Show
	</button>
	{#if show}
	<div class="w-fit h-fit bg-[#25303B] p-2">
		{#each options as option}
		<div class="flex flex-row gap-2 items-center">
			<p class="text-white mr-4">{option.component}</p>
			{#each option.actions as action}
			<button class="bg-[#0098A3] text-white p-2"
				on:click={() => {

					if (action.custom == true) {
						action.customFunction();
						return
					}
					debugData([
						{
							action: action.action,
							data: action.data,
						},
					])
				}}
			>
			{action.name}
			</button>
			{/each}
		</div>
		{/each}
	</div>
	{/if}
</div>