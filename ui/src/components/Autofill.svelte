<script>
	import { GANG_DATA, ITEM_DATA, JOB_DATA, LOCATION_DATA, VEHICLE_DATA, PED_LIST } from "@store/data"
	import { PLAYER } from "@store/players"
	import { SendNUI } from "@utils/SendNUI"
	import { onMount } from "svelte"
	import { slide } from "svelte/transition"

    export let action
    export let label_title
    export let data

    export let selectedData;

    let search = ""
    let searchInputFocused = false;
    let DataDropdownActive = false;

    function selectData(label, value) {
        search = label;
        DataDropdownActive = false;

        selectedData({
            label: label,
            value: value,
            id: label_title
        });
    }

    function handleInputFocus() {
        searchInputFocused = true;
        DataDropdownActive = true;
        search = ""
    }

    function handleInputBlur() {
        if (!searchInputFocused) {
            DataDropdownActive = false;
        }
        searchInputFocused = false;
    }
    
    async function GetPlayers() {
        const players = await SendNUI("getPlayers");
        PLAYER.set(players);
    }

    onMount(() => {
        if (data === "players") {
            GetPlayers();
        }
    })
</script>

<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh] border-[0.1vh] border-primary">
    <div class="w-full h-[3.8vh] px-[1vh] flex justify-between items-center">
        <input 
            type="text" 
            placeholder={label_title} 
            on:focus={handleInputFocus}
            on:blur={handleInputBlur}
            bind:value={search}
            class="h-full w-[90%] bg-transparent" 
        />
        <i class="fas fa-angle-{DataDropdownActive ? "down" : "right"} text-[1.2vh]"></i>
    </div>

    {#if DataDropdownActive}
        <button 
            class="w-full rounded-b-[0.5vh] flex flex-col max-h-[15vh] overflow-y-auto border-t border-primary scroll-visible"
            on:mouseenter={() => { searchInputFocused = true }}
            on:blur={() => { searchInputFocused = false }}
            transition:slide={{ duration: 150 }}
        >
            {#if data === "players"}
                {#each $PLAYER.filter(i => i.name.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => 
                            selectData(i.name, i.id)
                        }
                    >
                        <p>{i.name}</p>
                        <p>({i.id})</p>
                    </button>
                {/each}
            {:else if data === "vehicles"}
                {#each $VEHICLE_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "items"}
                {#each $ITEM_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "jobs"}
                {#each $JOB_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "gangs"}
                {#each $GANG_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "locations"}
                {#each $LOCATION_DATA.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else if data === "pedlist"}
                {#each $PED_LIST.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <p>({i.value})</p>
                    </button>
                {/each}
            {:else}
                {#each data.filter(i => i.label.toLowerCase().includes(search.toLowerCase()) || i.value.toLowerCase().includes(search.toLowerCase())) as i}
                    <button 
                        class="w-full p-[0.5vh] flex justify-start text-start px-[1vh] gap-[0.5vh] hover:bg-tertiary"
                        on:click={() => selectData(i.label, i.value)}
                    >
                        <p>{i.label}</p>
                        <!-- <p>({i.value})</p> -->
                    </button>
                {/each}
            {/if}
        </button>
    {/if}
</div>

