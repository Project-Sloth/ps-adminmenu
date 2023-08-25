<script lang="ts">
	import { ACTION } from '@store/actions'
	import { ITEM_DATA, VEHICLE_DATA, JOB_DATA, GANG_DATA, LOCATION_DATA } from '@store/data'
	import { PLAYER, PLAYER_DATA } from '@store/players'
	import { RESOURCE, RESOURCES } from '@store/server'
	import { ReceiveNUI } from '@utils/ReceiveNUI'
	import { debugData } from '@utils/debugData'


	debugData([
		{
			action: 'setVisible',
			data: true,
		},
	])

	debugData([
		{
			action: 'setBrowserMode',
			data: true
		},
	])

	ReceiveNUI('setupUI', (data: any) => {
		$ACTION = data.actions
		$RESOURCE = data.resources
		$PLAYER_DATA = data.playerData
	})

	ReceiveNUI('setResourceData', (data: any) => {
		$RESOURCE = data
	})

	ReceiveNUI('setPlayersData', (data: any) => {
		$PLAYER = data
	})

	ReceiveNUI('data', (data: any) => {
		$VEHICLE_DATA = data.vehicles
		$ITEM_DATA = data.items
		$JOB_DATA = data.jobs
		$GANG_DATA = data.gangs
		$LOCATION_DATA = data.locations
	})

</script>
