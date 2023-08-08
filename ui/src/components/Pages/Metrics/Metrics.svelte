<script lang="ts">
    import { toggleWideMenu, menuWideStore, SERVERMETRICS } from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'
    import { fade } from 'svelte/transition';
    import { createEventDispatcher } from 'svelte';

    if (!$menuWideStore.isMenuWide) {
        toggleWideMenu();
    }

</script>

<div class="w-full h-full flex flex-col">
{#if $menuWideStore.isMenuWide}
    <div class="w-full h-[8px] border-b-4 border-tertiary p-8 px-8 font-medium text-[2.2rem]">Server Metrics</div>
    {#if $SERVERMETRICS }
        {#each $SERVERMETRICS as metrics, i}
            <div class="w-full bg-[#26343a] p-4 rounded-lg shadow-md">
                <div class="card-item">
                    <p><strong>Total Unique Players:</strong> {metrics.UniquePlayers}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Characters:</strong> {metrics.CharacterCount}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Cash:</strong> ${metrics.TotalCash}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Bank:</strong> ${metrics.TotalBank}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Items:</strong> {metrics.TotalItems}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Vehicles:</strong> {metrics.VehicleCount}</p>
                </div>
                <div class="card-item">
                    <p><strong>Total Bans:</strong> {metrics.BansCount}</p>
                </div>
            </div>
        {/each}
    {/if}
{/if}
</div>


<style>
    .card-item {
        background-color: #424242;
        border-radius: 8px;
        padding: 16px;
        margin: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
</style>