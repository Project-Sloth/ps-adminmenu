<script lang="ts">
    import {toggleWideMenu, menuWideStore, PLAYERSBUTTONS, PLAYERS, VEHICLES} from '@store/stores';
	import { SendNUI } from '@utils/SendNUI'
    import { fade } from 'svelte/transition';
    import { createEventDispatcher } from 'svelte';
    let visible = false;
    const dispatch = createEventDispatcher();


    const started = Array().fill(false);

    let searchTerm = '';

    let selectedPlayer = null;

    function SelectPlayer(button) {
        selectedPlayer = button;

        if (!$menuWideStore.isMenuWide) {
            toggleWideMenu();
        }
    }

    function clickHandler() {
		visible = !visible
	}
    let time = null
    let reason = ''

    let selected;
    function selectOption(option) {
        selected = option;
    dispatch('optionSelected', option);
    }
</script>

<div class="w-full h-full flex flex-row ">
    <div>
        <!-- Search Bar -->
        <div class="h-[7.5rem] w-full border-b-2 border-tertiary flex items-center justify-center">
            <input class="ml-8 mt-2 w-full h-[95%] bg-transparent font-medium text-[2.1rem]" type="text" placeholder="Search" bind:value={searchTerm}>
            <button on:click={ () => { SendNUI("RefreshResources") }} class="fa-solid fa-arrows-rotate fa-xl hover:bg-tertiary h-full w-40"></button>
        </div>
        <!-- Player List -->
        <div class="w-[37.3rem] h-[91.5%] flex items-center flex-col overflow-auto ">
            <!-- Players -->
            {#if $PLAYERSBUTTONS && $PLAYERS}
                {#each $PLAYERS.filter(button => button.name.toLowerCase().includes(searchTerm.toLowerCase()) || (button.author && button.author.toLowerCase().includes(searchTerm.toLowerCase()))) as button, i}
                    <button on:click={() => {
                    SelectPlayer(button)
                    SendNUI("normalButton", {
                            event: 'ps-adminmenu:client:GetVehicles',
                            type: 'client',
                            data: button.cid,
                            perms: 'admin'
                        });
                    }} class=" mt-2 w-[94%] min-h-[10rem] bg-primary text-start px-4 flex items-center hover:bg-tertiary">
                        <div>
                            <p class="font-medium text-[2.5rem] ml-3">{button.id} - {button.name}</p>

                            <p class="font-medium text-[1.4rem] ml-3 mt-1">Citizen ID: {button.cid ?? 'none'}</p>
                        </div>
                        <div class="flex justify-center items-center flex-row-reverse ml-auto mr-4">
                            <i class="fas fa-angle-right fa-lg"></i>
                        </div>
                    </button>
                {/each}
            {/if}
        </div>
    </div>

    {#if $menuWideStore.isMenuWide && selectedPlayer}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col">
            <p class="font-medium text-[1.4rem] ml-3 mt-1">Citizen ID: {selectedPlayer.cid ?? 'none'}</p>

            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[3.2rem]">
                {selectedPlayer.id} - {selectedPlayer.name}
            </div>
            <div class="font-medium text-[2.8rem] ml-3 mt-1">Licenses:
                <p class="font-medium text-[1.8rem] ml-3 mt-1">License: {selectedPlayer.license ?? 'none'}</p>
                <p class="font-medium text-[1.8rem] ml-3 mt-1">Discord: {selectedPlayer.discord ?? 'none'}</p>
                <p class="font-medium text-[1.8rem] ml-3 mt-1">Steam: {selectedPlayer.steam ?? 'none'}</p>
            </div>
            <div class="font-medium text-[2.8rem] ml-3 mt-1">Player Information:
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-suitcase fa-lg"></i> Job: </p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{selectedPlayer.job ?? 'none'}</i>
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-calendar-day fa-lg"></i> Date of birth: </p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{selectedPlayer.dob ?? 'none'}</i>
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-money-bill-1 fa-lg"></i> Cash: </p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{selectedPlayer.cash ?? 'none'} $</i>
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-money-check-dollar fa-lg"></i> Bank: </p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{selectedPlayer.bank ?? 'none'} $</i>
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-phone fa-lg"></i> Phone:</p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{selectedPlayer.phone ?? 'none'}</i>
                <!-- {#each $VEHICLES.filter(vehicle => vehicle.cid === selectedPlayer.cid) as vehicle}
                <p class="font-medium text-[1.8rem] ml-3 mt-1"><i class="fas fa-car fa-lg"></i> Owned Vehicles:</p> <i class=" flex ... font-light text-[1.8rem] ml-3 mt-1">{vehicle.label ?? 'none'}</i>
                {/each} -->
            </div>
            <div>
                {#if $VEHICLES}
                    <p class="font-medium text-[1.8rem] ml-3 mt-1">Personal Vehicles</p>
                    <select class='bg-secondary p-3 w-[25rem] mt-1 font-medium hover:bg-tertiary' bind:value={selected}>
                        {#each $VEHICLES.filter(vehicle => vehicle.cid === selectedPlayer.cid) as vehicle}
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
                            perms: 'admin'
                        });
                    }}
                    >
                    Spawn Vehicle
                    </button>
                {/if}
            </div>
            <div class="flex ...">
                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary"
                    on:click={() => {
                        SendNUI("normalButton", {
                            event: 'ps-adminmenu:server:KickPlayer',
                            type: 'server',
                            data: {["Player ID"]: selectedPlayer.id},
                            perms: 'admin'
                        });
                    }}
                    >
                    Kick Player
                </button>
                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary border-l-2 border-tertiary"
                    on:click={clickHandler}>Ban Player</button>
                {#if visible}
                        <input class="dropdown-content bg-secondary p-3 w-[12rem] mt-1 font-medium" transition:fade type="number" placeholder="Time" bind:value={time}/>
                        <input class="dropdown-content bg-secondary p-3 w-[12rem] mt-1 font-medium border-l-2 border-tertiary" transition:fade placeholder="Reason" bind:value={reason}/>
                        <button transition:fade class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary"
                            on:click={() => {
                                SendNUI("normalButton", {
                                    event: 'ps-adminmenu:server:BanPlayer',
                                    type: 'server',
                                    data: {["Player ID"]: selectedPlayer.id, ["Time"]: time, ["Reason"]: reason},
                                    perms: 'admin'
                                });
                            }}
                            >
                            BAN!
                        </button>
                {/if}
                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary border-l-2 border-tertiary"
                    on:click={() => {
                        SendNUI("normalButton", {
                            event: 'ps-adminmenu:server:TeleportToPlayer',
                            type: 'server',
                            data: {["Player ID"]: selectedPlayer.id},
                            perms: 'admin'
                        });
                    }}
                    >
                    Go to Player
                </button>
                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary border-l-2 border-tertiary"
                    on:click={() => {
                        SendNUI("normalButton", {
                            event: 'ps-adminmenu:server:Revive',
                            type: 'server',
                            data: {["Player ID"]: selectedPlayer.id},
                            perms: 'admin'
                        });
                    }}
                    >
                    Revive Player
                </button>
                <button class="bg-secondary p-3 w-[12rem] mt-1 font-medium hover:bg-tertiary border-l-2 border-tertiary"
                    on:click={() => {
                        SendNUI("normalButton", {
                            event: 'ps-adminmenu:server:SpectateTarget',
                            type: 'server',
                            data: {["Player ID"]: selectedPlayer.id},
                            perms: 'admin'
                        });
                    }}
                    >
                    Spectate Player
                </button>
            </div>
        </div>
    {:else if $menuWideStore.isMenuWide}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col">
            <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[2.2rem]">
                Select a player
            </div>

            <div class="w-full h-full flex items-center justify-center flex-col">
                <img class="w-[18rem] opacity-50" src="https://i.imgur.com/CJXACFN.png" alt="">
                <p class="mb-[10rem] mt-8 text-tertiary text-[2.5rem] font-bold w-[26rem] text-center opacity-50">You have not selected a player!</p>
            </div>
        </div>
    {/if}

</div>

