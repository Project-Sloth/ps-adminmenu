<script>
	import { PLAYER_VEHICLES, SELECTED_PLAYER } from '@store/players'
	import { MENU_WIDE } from '@store/stores'
	import { SendNUI } from '@utils/SendNUI'

	export let player

	async function SelectPlayer(player) {
		SELECTED_PLAYER.set(player)
		MENU_WIDE.set(true)
		const vehicles = await SendNUI('getVehicle', { cid: $SELECTED_PLAYER.cid });
		PLAYER_VEHICLES.set(vehicles);
	}
</script>

<button
	class="h-[4.5vh] w-full flex items-center px-[1.5vh] rounded-[0.5vh] bg-tertiary hover:bg-opacity-90"
	on:click={() => {
		SelectPlayer(player)
	}}
>
	<div class="w-full flex items-center justify-between gap-[1vh]">
		<p>{player.id} - {player.name}</p>
		<i class="fas fa-angle-right" />
	</div>
</button>
