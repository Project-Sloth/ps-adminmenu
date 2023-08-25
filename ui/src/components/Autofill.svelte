<script>
	import { GANG_DATA, ITEM_DATA, JOB_DATA, LOCATION_DATA, VEHICLE_DATA } from "@store/data"
	import { PLAYER } from "@store/players"
	import { slide } from "svelte/transition"

    export let action
    export let label
    export let data

    let DataDropdownActive = false

</script>

<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh] border-[0.1vh] border-primary">
    <div class="w-full h-[3.8vh] px-[1vh] flex justify-between items-center">
        <input 
            type="text" 
            placeholder={label} 
            on:focus={() => (DataDropdownActive = true)} 
            on:blur={() => (DataDropdownActive = false)}
            class="h-full w-[90%] bg-transparent" 
        />
        <i class="fas fa-angle-{DataDropdownActive ? "down" : "right"} text-[1.2vh]"></i>
    </div>

    {#if DataDropdownActive}
        <div 
            class="w-full rounded-b-[0.5vh] flex flex-col max-h-[15vh] overflow-y-auto border-t border-primary scroll-visble"
            transition:slide={{ duration: 150 }}
        >
            {#if data === "players"}
                {#each $PLAYER as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.player.id} - {i.player.name}</p>
                    </button>
                {/each}
            {:else if data === "vehicles"}
                {#each $VEHICLE_DATA as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.name} - [{i.model}]</p>
                    </button>
                {/each}
            {:else if data === "items"}
                {#each $ITEM_DATA as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.label} - ({i.name})</p>
                    </button>
                {/each}
            {:else if data === "jobs"}
                {#each $JOB_DATA as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.label} - ({i.name}) - </p>
                    </button>
                {/each}
            {:else if data === "gangs"}
                {#each $GANG_DATA as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.label} - ({i.name}) - </p>
                    </button>
                {/each}
            {:else if data === "locations"}
                {#each $LOCATION_DATA as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.name}</p>
                    </button>
                {/each}
            {:else}
                {#each data as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                    </button>
                {/each}
            {/if}
        </div>
    {/if}
</div>

