<script>
	import { MENU_WIDE } from '@store/stores'
	import { Message, Messages } from '@store/staffchat'
    import { PLAYER, PLAYER_DATA } from "@store/players";
    import { timeAgo } from "@utils/timeAgo"
	import { SendNUI } from '@utils/SendNUI'
	import { onMount } from 'svelte'

    function refreshMsg() {
        SendNUI("GetMessages");
    }

    onMount(() => {
        const RefreshMsgInterval = setInterval(() => {
            refreshMsg()
        }, 1000)
        return () => clearInterval(RefreshMsgInterval)
    })

</script>

<div>

    <div>
        {#if $Message && $Messages}
            {#each $Message as message}
                <div class="w-full flex flex-col text-[1.3vh] text-gray-400 {$PLAYER && $PLAYER_DATA.cid === message.citizenid ? "items-end" : "items-start"}">
                    <div class="w-fit flex justify-between items-center text-gray-400 font-medium -mb-[0.5vh]">
                        <p class="text-[1.2vh]">{message.fullname}</p>
                    </div>
                    <div class="w-fit max-w-[85%] mt-[0.5vh] p-[1vh] break-words text-start rounded-lg {$PLAYER && $PLAYER_DATA.cid === message.citizenid ? "bg-accent" : "bg-tertiary"}">
                        <p>{message.message}</p>
                    </div>
                    <p class="text-[1vh] ml-[0.5vh]">{timeAgo(Number(message.time))}</p>
                </div>
            {/each}
        {/if}
    </div>

</div>