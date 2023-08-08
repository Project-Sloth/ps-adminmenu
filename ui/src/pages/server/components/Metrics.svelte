<script>
    import { SERVERMETRICS, menuWideStore } from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'
	import { onMount } from 'svelte'

    onMount(() => {
        SendNUI("GetMetrics");
    });
</script>

{#if $menuWideStore.isMenuWide}
    <div class="w-[75vh] h-full font-medium border-l-[0.3vh] border-tertiary">
        <div class="flex items-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
            <p>Server Information</p>
        </div>
        <div class="w-full flex justify-center">
            {#if $SERVERMETRICS }
                {#each $SERVERMETRICS as metrics, i}
                    <div class="w-[35%] bg-primary p-[1vh]">
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
        </div>

    </div>
{/if}

