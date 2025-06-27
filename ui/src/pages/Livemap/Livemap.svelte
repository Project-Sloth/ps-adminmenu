<script lang="ts">
	import { MENU_WIDE } from '@store/stores'
	import { PLAYER, SELECTED_PLAYER } from '@store/players'
	import Header from '@components/Header.svelte'
	import Spinner from '@components/Spinner.svelte'
	import Button from './components/Button.svelte'

	import { onMount, tick, onDestroy } from 'svelte'
	import { SendNUI } from '@utils/SendNUI'
	import { get } from 'svelte/store'

	import L from 'leaflet'
	import 'leaflet/dist/leaflet.css'

	let search = ''
	let loading = false
	let pollInterval: any;

	let mapContainer: HTMLDivElement
	let mapInitialized = false
	let map: L.Map | null = null
	let markers: Record<string, L.Marker> = {}

	MENU_WIDE.subscribe(async (value) => {
		if (value) {
			await tick()
			if (mapContainer && !mapInitialized) {
				if (!mapContainer) {
					console.error('Map container not found!')
					return
				}
				initializeMap()
			}
		}
	})

	function initializeMap() {
		mapInitialized = true

		const CustomCRS = L.extend({}, L.CRS.Simple, {
			projection: L.Projection.LonLat,
			scale: function(zoom) {
				return Math.pow(2, zoom);
			},
			zoom: function(sc) {
				return Math.log(sc) / 0.6931471805599453;
			},
			distance: function(pos1, pos2) {
				var x_difference = pos2.lng - pos1.lng;
				var y_difference = pos2.lat - pos1.lat;
				return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
			},
			transformation: new L.Transformation(0.02072, 117.3, -0.0205, 172.8),
			infinite: false
		});

		map = L.map(mapContainer, {
			crs: CustomCRS,
			minZoom: 3,
			maxZoom: 10,
			zoom: 5,
			noWrap: true,
			continuousWorld: false,
			preferCanvas: true,
			center: [0, -1024],
			maxBoundsViscosity: 1.0,
		})

		const imageUrl =
			'https://files.fivemerr.com/images/60c68fc9-1a7f-4e5a-800a-f760a74186ca.jpeg'
		const sw = map.unproject([0, 1024], 3 - 1)
		const ne = map.unproject([1024, 0], 3 - 1)

		const bounds = new L.LatLngBounds(sw, ne)

		map.setView([-300, -1500], 4)
		map.setMaxBounds(bounds)
		map.attributionControl.setPrefix(false)
		L.imageOverlay(imageUrl, bounds).addTo(map)

		map.on('dragend', () => {
			if (!bounds.contains(map.getCenter())) {
				map.panTo(bounds.getCenter(), { animate: false })
			}
		})

		updatePlayerMarkers()
	}


	function updatePlayerMarkers() {
		if (!map) return

		const players = get(PLAYER)

		for (const id in markers) {
			if (!players.find((p) => String(p.id) === id)) {
				map.removeLayer(markers[id])
				delete markers[id]
			}
		}

		for (const player of players) {
			const pos = player?.pos;
			if (!pos || typeof pos.x !== 'number' || typeof pos.y !== 'number') continue;
			const key = String(player.id);
			if (markers[key]) {
				markers[key].setLatLng([pos.y, pos.x]);
			} else {
				const userIcon = L.divIcon({
					html: '<i class="fas fa-circle-user" style="font-size:24px;color:#2e89ff;"></i>',
					className: 'custom-fa-icon',
					iconSize: [32, 32],
					iconAnchor: [16, 0],
				});
				const marker = L.marker([pos.y, pos.x], { icon: userIcon });
				marker.bindPopup(`
					<div>
						<b>${player.name}</b>
						<div style="margin-top: 10px; display: flex; gap: 8px;">
							<button class="popup-action-btn" data-action="bring" data-id="${player.id}">Bring</button>
							<button class="popup-action-btn" data-action="goto" data-id="${player.id}">Goto</button>
							<button class="popup-action-btn" data-action="spectate" data-id="${player.id}">Spectate</button>
						</div>
					</div>
				`, {
					className: 'custom-leaflet-popup'
				});
				marker.on('click', () => {
					SELECTED_PLAYER.set(player);
					marker.openPopup();
				});
				marker.on('popupopen', (e) => {
					const popup = e.popup.getElement();
					if (!popup) return;
					popup.querySelectorAll('.popup-action-btn').forEach((btn) => {
						btn.addEventListener('click', (event) => {
							const action = btn.getAttribute('data-action');
							const id = btn.getAttribute('data-id');
							if (action === 'bring') {
								SendNUI('clickButton', {
									data: 'bringPlayer',
									selectedData: {
										['Player']: {
											value: id,

										},
									},
								});
							} else if (action === 'goto') {
								SendNUI('clickButton', {
									data: 'teleportToPlayer',
									selectedData: {
										['Player']: {
											value: id,

										},
									},
								});
							} else if (action === 'spectate') {
								SendNUI('clickButton', {
									data: 'spectate_player',
									selectedData: {
										['Player']: {
											value: id,
										},
									},
								})
							}
						});
					});
				});
				marker.addTo(map);
				markers[key] = marker;
			}
		}
	}



	const unsubscribePlayers = PLAYER.subscribe(() => {
		if (map) updatePlayerMarkers()
	})

	const unsubscribeSelected = SELECTED_PLAYER.subscribe((player) => {
		if (
			player &&
			map &&
			player.pos &&
			typeof player.pos.x === 'number' &&
			typeof player.pos.y === 'number' &&
			markers[player.id]
		) {
			// Zoom in to level 8 (adjust as needed)
			map.setView([player.pos.y, player.pos.x], 5, { animate: true });
			markers[player.id].openPopup();
		}
	})

	onMount(async () => {
		MENU_WIDE.set(true)
		loading = true

		const players = await SendNUI('getPlayers')
		PLAYER.set(players)

		loading = false

		await tick()
		updatePlayerMarkers()

		// Start polling for live updates every second
		pollInterval = setInterval(async () => {
			const players = await SendNUI('getPlayers')
			PLAYER.set(players)
		}, 1000)
	})

	onDestroy(() => {
		unsubscribePlayers()
		unsubscribeSelected()
		if (pollInterval) clearInterval(pollInterval)
	})
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header
		title={'Live Map'}
		hasSearch={true}
		onSearchInput={(event) => (search = event.target.value)}
	/>
	<div class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto">
		{#if loading}
			<Spinner />
		{:else if $PLAYER}
			{#if $PLAYER.filter((player) => player.name
					.toLowerCase()
					.includes(search.toLowerCase())).length === 0}
				<div
					class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]"
				>
					No Player Found.
				</div>
			{:else}
				{#each $PLAYER.filter((player) => player.name
						.toLowerCase()
						.includes(search.toLowerCase())) as player (player.id)}
					<Button {player} />
				{/each}
			{/if}
		{/if}
	</div>
</div>

{#if $MENU_WIDE}
	<div class="h-full w-[66vh] border-l-[0.2vh] border-tertiary p-[2vh]">
		<div
			bind:this={mapContainer}
			class="w-full h-full rounded-[1vh] overflow-hidden z-0"
		/>
	</div>
{/if}


<style>
/* Strong selectors to override Leaflet popup styles */
.leaflet-popup.custom-leaflet-popup,
.leaflet-popup.custom-leaflet-popup .leaflet-popup-content-wrapper,
.leaflet-popup.custom-leaflet-popup .leaflet-popup-content {
    background: #181c23 !important;
    color: #fff !important;
    border-radius: 12px !important;
    box-shadow: 0 4px 24px 0 rgba(0,0,0,0.4) !important;
    font-family: inherit !important;
    font-size: 1rem !important;
    border: none !important;
    padding: 1rem 1.5rem !important;
    margin: 0 !important;
}

.leaflet-popup.custom-leaflet-popup .leaflet-popup-tip,
.leaflet-popup.custom-leaflet-popup .leaflet-popup-tip-container {
    background: #181c23 !important;
}

.leaflet-popup.custom-leaflet-popup {
    border-radius: 12px !important;
    border: none !important;
    box-shadow: 0 4px 24px 0 rgba(0,0,0,0.4) !important;
}

.popup-action-btn {
    background: #23272f;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 14px;
    cursor: pointer;
    transition: background 0.2s;
    font-size: 0.95rem;
}
.popup-action-btn:hover {
    background: #2e89ff;
}
</style>