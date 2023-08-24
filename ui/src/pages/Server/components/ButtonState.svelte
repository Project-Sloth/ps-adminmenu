<script>
	import { RESOURCE } from '@store/server'
	import { SendNUI } from '@utils/SendNUI'

	export let resource
	export let icon
	export let state

	async function changeState() {
		event.stopPropagation();
		const data = await SendNUI('setResourceState', { name: resource, state: state });
		RESOURCE.set(data);
	}
</script>

<button
	class="w-[3vh] h-[3vh] rounded-[0.5vh] bg-secondary hover:bg-primary"
	on:click={changeState}
>
	<i class={icon} />
</button>
