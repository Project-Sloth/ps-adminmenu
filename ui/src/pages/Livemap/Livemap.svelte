<script lang="ts">
    import { MENU_WIDE } from '@store/stores';
    import { PLAYER, SELECTED_PLAYER } from '@store/players';
    import Header from '@components/Header.svelte';
    import Spinner from '@components/Spinner.svelte';
    import Button from './components/Button.svelte';

    import { onMount, tick, onDestroy } from 'svelte';
    import { SendNUI } from '@utils/SendNUI';
    import { get } from 'svelte/store';

    import L from 'leaflet';
    import 'leaflet/dist/leaflet.css';

    let search = '';
    let loading = false;
    let pollInterval: ReturnType<typeof setInterval>;

    let mapContainer: HTMLDivElement | null;
    let mapInitialized = false;
    let map: L.Map | null = null;
    let markers: Record<string, L.Marker> = {};
	let followPlayer = false;


	MENU_WIDE.subscribe(async (value) => {
		if (!value) return;
		await tick();
		try {
			if (mapInitialized) return;
			if (!mapContainer) throw new Error('Map container not found!');
			initializeMap();
		} catch (err) {
			console.error(err);
		}
	});

	function getCustomCRS() {
		const zoomNumb = 0.6931471805599453;
		return L.extend({}, L.CRS.Simple, {
			projection: L.Projection.LonLat,
			scale: function (zoom) {
				return Math.pow(2, zoom);
			},
			zoom: function (sc) {
				return Math.log(sc) / zoomNumb;
			},
			distance: function (pos1, pos2) {
				var x_difference = pos2.lng - pos1.lng;
				var y_difference = pos2.lat - pos1.lat;
				return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
			},
			transformation: new L.Transformation(0.02072, 117.3, -0.0205, 172.8),
			infinite: false
		});
	}

	function getMapBounds(map: L.Map) {
		const sw = map.unproject([0, 1024], 2);
		const ne = map.unproject([1024, 0], 2);
		return new L.LatLngBounds(sw, ne);
	}

	function addMapImageOverlay(map: L.Map, bounds: L.LatLngBounds) {
		const imageUrl = 'https://files.fivemerr.com/images/60c68fc9-1a7f-4e5a-800a-f760a74186ca.jpeg';
		L.imageOverlay(imageUrl, bounds).addTo(map);
	}

	function setupMapEvents(map: L.Map, bounds: L.LatLngBounds) {
		map.on('dragend', () => {
			if (!bounds.contains(map.getCenter())) {
				map.panTo(bounds.getCenter(), { animate: false });
			}
		});
	}

	function initializeMap() {
		mapInitialized = true;
		const CustomCRS = getCustomCRS();

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
		});

		const bounds = getMapBounds(map);
		map.setView([-300, -1500], 4);
		map.setMaxBounds(bounds);
		map.attributionControl.setPrefix(false);

		addMapImageOverlay(map, bounds);
		setupMapEvents(map, bounds);

		updatePlayerMarkers();
	}

	function removeStaleMarkers(players) {
		for (const id in markers) {
			if (!players.find((p) => String(p.id) === id)) {
				map.removeLayer(markers[id]);
				delete markers[id];
			}
		}
	}

	function handlePopupActions(popup: HTMLElement) {
		const actionMap: Record<string, string> = {
			bring: 'bringPlayer',
			goto: 'teleportToPlayer',
			spectate: 'spectate_player'
		};

		popup.querySelectorAll('.popup-action-btn').forEach((btn) => {
			btn.addEventListener('click', (event) => {
				const action = btn.getAttribute('data-action');
				const id = btn.getAttribute('data-id');
				const data = actionMap[action];
				if (data && id) {
					SendNUI('clickButton', {
						data,
						selectedData: { ['Player']: { value: id } }
					});
				}
			});
		});
	}

	function createPlayerMarker(player) {
		const pos = player?.pos;
		if (!pos || typeof pos.x !== 'number' || typeof pos.y !== 'number') return null;
		const key = String(player.id);

		const userIcon = L.divIcon({
			html: '<i class="fas fa-circle-user" style="font-size:24px;color:#23272f;"></i>',
			className: 'custom-fa-icon',
			iconSize: [32, 32],
			iconAnchor: [16, 0],
		});

		const marker = L.marker([pos.y, pos.x], { icon: userIcon });
		marker.bindPopup(`
			<div>
				<b style='font-size: 1.5rem; font-weight: bold; text-align: center; color: #e0e0e0;'>${player.name}</b>
				<div style="margin-top: 10px; display: flex; gap: 8px; font-size: 1.0rem; color: #e0e0e0; text-decoration: underline;">
					<button class="popup-action-btn" data-action="bring" data-id="${player.id}">Bring</button>
					<button class="popup-action-btn" data-action="goto" data-id="${player.id}">Goto</button>
					<button class="popup-action-btn" data-action="spectate" data-id="${player.id}">Spectate</button>
				</div>
			</div>
		`, {
			className: 'black-popup',
			offset: [ -3, 0 ],
		});

		marker.on('click', () => {
			SELECTED_PLAYER.set(player);
			marker.openPopup();
		});

		marker.on('popupopen', (e) => {
			const popup = e.popup.getElement();
			if (!popup) return;
			handlePopupActions(popup);
		});

		marker.on('popupclose', () => {
			followPlayer = false;
			SELECTED_PLAYER.set(null);
		});

		marker.addTo(map);
		markers[key] = marker;
		return marker;
	}

	function updateOrCreateMarkers(players) {
		for (const player of players) {
			const pos = player?.pos;
			if (!pos || typeof pos.x !== 'number' || typeof pos.y !== 'number') continue;
			const key = String(player.id);
			if (markers[key]) {
				markers[key].setLatLng([pos.y, pos.x]);
			} else {
				createPlayerMarker(player);
			}
		}
	}

	function updatePlayerMarkers() {
		if (!map) return;
		const players = get(PLAYER);
		removeStaleMarkers(players);
		updateOrCreateMarkers(players);
	}

    const unsubscribePlayers = PLAYER.subscribe(() => {
        if (map) updatePlayerMarkers();
    });

	const unsubscribeSelected = SELECTED_PLAYER.subscribe((player) => {
		followPlayer = !!player;
		if (
			player &&
			map &&
			player.pos &&
			typeof player.pos.x === 'number' &&
			typeof player.pos.y === 'number' &&
			markers[player.id]
		) {
			map.setView([player.pos.y, player.pos.x], 5, { animate: true });
			markers[player.id].openPopup();
		}
	});


	onMount(async () => {
		MENU_WIDE.set(true);
		loading = true;

		const players = await SendNUI('getPlayers');
		PLAYER.set(players);

		loading = false;

		await tick();
		updatePlayerMarkers();

		pollInterval = setInterval(async () => {
			const positions = await SendNUI('getPlayersPos');
			if (positions && Array.isArray(positions)) {
				positions.forEach(pos => {
					const key = String(pos.id);
					if (
						markers[key] &&
						pos.pos &&
						typeof pos.pos.x === 'number' &&
						typeof pos.pos.y === 'number'
					) {
						markers[key].setLatLng([pos.pos.y, pos.pos.x]);
						// Only follow if followPlayer is true and this is the selected player
						const selected = get(SELECTED_PLAYER);
						if (
							followPlayer &&
							selected &&
							String(selected.id) === key &&
							map
						) {
							map.setView([pos.pos.y, pos.pos.x], map.getZoom(), { animate: true });
						}
					}
				});
			}
		}, 5000);
	});

    onDestroy(() => {
        unsubscribePlayers();
        unsubscribeSelected();
        if (pollInterval) clearInterval(pollInterval);
    });

	$: filteredPlayers = $PLAYER
        ? $PLAYER.filter((player) =>
            player.name.toLowerCase().includes(search.toLowerCase())
        )
        : [];
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
			{#if filteredPlayers.length === 0}
				<div class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]">
					No Player Found.
				</div>
			{:else}
				{#each filteredPlayers as player (player.id)}
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
:global(.black-popup .leaflet-popup-content-wrapper) {
	background: #181c23;
}
:global(.leaflet-popup-tip) {
	background: #181c23;
}
</style>
