<script>
    import { menuWideStore, selectedPlayer, VEHICLES} from '@store/stores';
    import { SendNUI } from '@utils/SendNUI';
    import { createEventDispatcher } from 'svelte';
    const dispatch = createEventDispatcher();
    let visible1 = false;
    let visible2 = false;

    let time = null
    let reason = ''

    let selected;
    function selectOption(option) {
        selected = option;
    dispatch('optionSelected', option);
    }

    $: if($selectedPlayer){
        SendNUI("normalButton", {
            event: 'ps-adminmenu:client:GetVehicles',
            type: 'client',
            data: $selectedPlayer.cid,
            perms: 'mod'
        });
    }
    function doEvent(event, player, time, reason) {
        SendNUI("normalButton", {
            event: `ps-adminmenu:server:${event}`,
            type: 'server',
            data: {["Player ID"]: player, ["Time"]: time, ["Reason"]: reason},
            perms: 'mod'
        });
    }

</script>

{#if $menuWideStore.isMenuWide}
    <div class="w-[75vh] h-full font-medium border-l-[0.3vh] border-tertiary">
        <div class="flex items-center gap-[0.8vh] p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
            <p>{$selectedPlayer ? $selectedPlayer.id + " -": ""}</p>
            <p>{$selectedPlayer ? $selectedPlayer.name + " -" : ""}</p>
            <p>{$selectedPlayer ? "#"+$selectedPlayer.cid : ""}</p>
        </div>
        <div class="flex flex-col justify-center p-[1.8vh] text-[1.8vh] w-full h-[10.5vh] border-b-[0.3vh] border-tertiary">
            <p class="text-[2.2vh]">Player Licenses:</p>
            <p>{$selectedPlayer ? $selectedPlayer.license: ""}</p>
        </div>
        <div class="flex flex-col justify-center p-[1.8vh] text-[1.8vh] w-full h-[25.5vh] border-b-[0.3vh] border-tertiary">
            <p class="text-[2.2vh]">Player Information</p>
            <p>Fullname: {$selectedPlayer ? $selectedPlayer.name: ""}</p>
            <p>CitizenID: {$selectedPlayer ? $selectedPlayer.cid: ""}</p>
            <p>Date of Birth: {$selectedPlayer ? $selectedPlayer.dob: ""}</p>
            <p>Work: {$selectedPlayer ? $selectedPlayer.job: ""}</p>
            <p>Cash: {$selectedPlayer ? $selectedPlayer.cash: ""}</p>
            <p>Bank: {$selectedPlayer ? $selectedPlayer.bank: ""}</p>
        </div>
        {#if $VEHICLES}
            <div class="flex flex-col justify-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
                <p class="text-[2.2vh]">Player Vehicles</p>
            </div>
            <select class='bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary' bind:value={selected}>
                {#each $VEHICLES.filter(vehicle => vehicle.cid === $selectedPlayer.cid) as vehicle}
                    <div class=" hover:bg-primary p-3" on:click={() => selectOption(vehicle.label)}>{vehicle.label}</div>
                    <option value={vehicle.plate}>{vehicle.label}</option>
                {/each}
            </select>
            <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary"
            on:click={() => {
                SendNUI("normalButton", {
                    event: 'ps-adminmenu:client:SpawnPersonalvehicle',
                    type: 'client',
                    data: {['Personal Vehicle']: selected},
                    perms: 'mod'
                });
            }}
            >
            Spawn Vehicle
            </button>
        {/if}

        <div class="flex flex-col justify-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
            <p class="text-[2.2vh]">Player Actions</p>
        </div>
        <div class="flex flex-coljustify-center text-[1.4vh] w-full h-[5vh] border-b-[0.3vh] border-tertiary">
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary" on:click={() => visible1 = !visible1}>Kick Options</button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary" on:click={() => visible2 = !visible2}>Ban Options</button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary" on:click={() => {
                doEvent('TeleportToPlayer', $selectedPlayer.id)
            }}>
                Go to Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary"on:click={() => {
                doEvent('BringPlayer', $selectedPlayer.id)
            }}>
                Bring Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary"on:click={() => {
                doEvent('Revive', $selectedPlayer.id)
            }}>
                Revive Player
            </button>
            <button class="w-full hover:bg-tertiary"on:click={() => {
                doEvent('SpectateTarget', $selectedPlayer.id)
            }}>
                Spectate Player
            </button>
        </div>
        {#if visible1}
            <ul class="bg-secondary p-3 w-[25rem] mt-1 font-medium flex flex-col">
                <input class="bg-secondary p-3 w-[25rem] mt-1 font-medium" type="text" placeholder="Reason" bind:value={reason} />
                <button class="w-full hover:bg-tertiary border-[0.3vh] rounded-md border-tertiary" on:click={() => {
                    doEvent('KickPlayer', $selectedPlayer.id, reason)
                }}>
                    Kick {$selectedPlayer.name}
                </button>
            </ul>
        {/if}
        {#if visible2}
            <ul class="bg-secondary p-3 w-[25rem] mt-1 font-medium flex flex-col">
                <input class="bg-secondary p-3 w-[25rem] mt-1 font-medium" type="number" placeholder="Time" bind:value={time}/>
                <input class="bg-secondary p-3 w-[25rem] mt-1 font-medium" type="text" placeholder="Reason" bind:value={reason} />
                <button class="w-full hover:bg-tertiary border-[0.3vh] rounded-md border-tertiary" on:click={() => {
                    doEvent('BanPlayer', $selectedPlayer.id, time, reason)
                }}>
                    Ban {$selectedPlayer.name}
                </button>
            </ul>
        {/if}

    </div>
{/if}
