<script>
	import { GANG_DATA, ITEM_DATA, JOB_DATA, LOCATION_DATA, VEHICLE_DATA } from "@store/data"
	import { PLAYER } from "@store/players"
	import { slide } from "svelte/transition"

    export let action
    export let label
    export let data

    let DataDropdownActive = false

    let search = ""
</script>

<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh] border-[0.1vh] border-primary">
    <div class="w-full h-[3.8vh] px-[1vh] flex justify-between items-center">
        <input 
            type="text" 
            placeholder={label} 
            on:focus={() => (DataDropdownActive = true)} 
            on:blur={() => (DataDropdownActive = false)}
            bind:value={search}
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
                {#each $PLAYER.filter(i => i.player.name.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>({i.player.id})</p>
                        <p>{i.player.name}</p>
                    </button>
                {/each}
            {:else if data === "vehicles"}
                {#each $VEHICLE_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "items"}
                {#each $ITEM_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "jobs"}
                {#each $JOB_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "gangs"}
                {#each $GANG_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "locations"}
                {#each $LOCATION_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else}
                {#each data.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary">
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {/if}
        </div>
    {/if}
</div>

