<script lang="ts">
	import { ReceiveNUI } from '../utils/ReceiveNUI'
	import { SendNUI } from '../utils/SendNUI'
	import { onMount } from 'svelte'
	import { BROWSER_MODE, MENU_WIDE, VISIBILITY } from '../store/stores'
	import BackdropFix from './BackdropFix.svelte'

	let isVisible: boolean
	let isBrowser: boolean

	BROWSER_MODE.subscribe((browser: boolean) => {
		isBrowser = browser
	})

	VISIBILITY.subscribe((visible: boolean) => {
		isVisible = visible
	})

	ReceiveNUI<boolean>('setVisible', (visible: boolean) => {
		VISIBILITY.set(visible)
	})

	ReceiveNUI('setBrowserMode', (data: boolean) => {
		BROWSER_MODE.set(data)
		// console.log('browser mode enabled')
	})

	onMount(() => {
		const keyHandler = (e: KeyboardEvent) => {
			if (isVisible && ['Escape'].includes(e.code)) {
				SendNUI('hideUI')
				VISIBILITY.set(false)
			}
			if (
				!isVisible &&
				['Escape'].includes(e.code) &&
				isBrowser === true
			) {
				VISIBILITY.set(true)
			}
		}

		window.addEventListener('keydown', keyHandler)

		return () => window.removeEventListener('keydown', keyHandler)
	})
</script>

{#if isVisible}
	<main class="w-screen h-screen flex justify-end items-center {!$MENU_WIDE ? " " : "justify-center"}">
		<slot />
	</main>
	<!-- <BackdropFix /> -->
{/if}

<style>
	main {
		position: absolute;
		left: 0;
		top: 0;
		z-index: 100;
		user-select: none;
		box-sizing: border-box;
		padding: 0;
		margin: 0;
		height: 100vh;
		width: 100vw;
	}
</style>
