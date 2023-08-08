<script>
    import { menuWideStore, selectedPlayer } from '@store/stores';
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
        <div class="flex flex-col justify-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
            <p class="text-[2.2vh]">Player Vehicles</p>
        </div>
                <!-- <div class="flex justify-center text-[1.4vh] w-full h-[5vh] border-b-[0.3vh] border-tertiary">
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary">
                Kick Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary">
                Ban Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary">
                Go to Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary">
                Bring Player
            </button>
            <button class="w-full hover:bg-tertiary border-r-[0.3vh] border-tertiary">
                Revive Player
            </button>
            <button class="w-full hover:bg-tertiary">
                Spectate Player
            </button>
        </div> -->

    </div>
{/if}

