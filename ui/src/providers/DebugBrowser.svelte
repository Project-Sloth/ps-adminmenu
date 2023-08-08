<script>
	import { debug } from 'svelte/internal'
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

	const debugPlayers = [
		{
			id: "1",
			citizenid: "ERP95808",
			name: "John Doe",
			job: "Police Officer",
			phone: "555-555-5555",
			discord: "discord:917110675220865025",
			dateofbirth: "01/12/2001",
			bank: "10022",
			cash: "2022",
			license: "license:9e9df5e3b52641da00f5b2aba25edc45317689b2",
		},
		{
			id: "2",
			citizenid: "ERP87521",
			name: "Jane Smith",
			job: "Paramedic",
			phone: "555-555-1234",
			discord: "discord:732198415678290144",
			dateofbirth: "05/18/1990",
			bank: "8000",
			cash: "150",
			license: "license:5a0f4e86c7d283b3cde6acba9821d4a5913076d8",
		},
		{
			id: "3",
			citizenid: "ERP35267",
			name: "Michael Johnson",
			job: "Mechanic",
			phone: "555-555-9876",
			discord: "discord:609827518329704632",
			dateofbirth: "11/03/1985",
			bank: "500",
			cash: "3500",
			license: "license:c5f2b76a8e1e0d4c7892a3d1b74cf561b89e25e7",
		},
		{
			id: "4",
			citizenid: "ERP70125",
			name: "Emily Davis",
			job: "Lawyer",
			phone: "555-555-2222",
			discord: "discord:815369027403189267",
			dateofbirth: "09/21/1988",
			bank: "22000",
			cash: "500",
			license: "license:3d4e6f7aa1b9e8c5d2fbc0439e1a865b470192f4",
		},
		{
			id: "5",
			citizenid: "ERP48039",
			name: "Robert Wilson",
			job: "Taxi Driver",
			phone: "555-555-7777",
			discord: "discord:518942015678302479",
			dateofbirth: "07/08/1977",
			bank: "1200",
			cash: "780",
			license: "license:98e7c6d5a2b3f1e4d0c9876a5432109bfedc8a76",
		},
		{
			id: "6",
			citizenid: "ERP91726",
			name: "Amanda Lee",
			job: "Chef",
			phone: "555-555-3333",
			discord: "discord:725048390162871590",
			dateofbirth: "03/15/1995",
			bank: "4000",
			cash: "200",
			license: "license:4a5b6c7d8e9f01234567890abcdef1234567890",
		},
		{
			id: "7",
			citizenid: "ERP24680",
			name: "Christopher Martinez",
			job: "Firefighter",
			phone: "555-555-8888",
			discord: "discord:926371058274690831",
			dateofbirth: "12/30/1982",
			bank: "7500",
			cash: "1000",
			license: "license:7890123456abcdef0123456789a5b4c3d2e1f0",
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
		{
			component: 'Player Data',
			actions : [
				{
					name: "Set Data",
					action: "setPlayersData",
					data: debugPlayers,
				},
			]
		},
		// {
		// 	component: 'Player Data',
		// 	actions : [
		// 		{
		// 			name: "Set Data",
		// 			action: "setPlayersData",
		// 			data: debugPlayers,
		// 		},
		// 	]
		// },
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