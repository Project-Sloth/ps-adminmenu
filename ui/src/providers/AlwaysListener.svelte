<script lang="ts">
	import { ReceiveNUI } from '@utils/ReceiveNUI'
	import { debugData } from '@utils/debugData'
	import { browserMode, visibility, ACTIONS, ACTIONSBUTTONS, RESOURCES, RESOURCESBUTTONS } from '@store/stores'

	function copyToClipboard(str) {
		const el = document.createElement('textarea');
		el.value = str;
		document.body.appendChild(el);
		el.select();
		document.execCommand('copy');
		document.body.removeChild(el);
	}
	
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

	function browserHideAndShow(e: KeyboardEvent) {
		if (e.key === '=') {
			$visibility = true
		}
	}

	ReceiveNUI('setBrowserMode', (data: boolean) => {
		browserMode.set(data)
		console.log('browser mode enabled')
		if (data) {
			window.addEventListener('keydown', browserHideAndShow)
		} else {
			window.removeEventListener('keydown', browserHideAndShow)
		}
	})

	ReceiveNUI('setActionData', (data: any) => {
		ACTIONS.set(data)
		ACTIONSBUTTONS.set($ACTIONS[0])
	})

	ReceiveNUI('setResourceData', (data: any) => {
		RESOURCES.set(data)
		RESOURCESBUTTONS.set($RESOURCES[0])
	})

	ReceiveNUI('CopyCoordinatesToClipboard', (data: any) => {
		console.log(data)
		copyToClipboard(data);
	})


</script>
