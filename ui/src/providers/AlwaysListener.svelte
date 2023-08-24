<script lang="ts">
	import { ACTION } from '@store/actions'
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

</script>
