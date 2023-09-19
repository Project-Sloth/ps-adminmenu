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
            {#each $Message.slice().reverse() as message}
                <!-- <div class="w-full flex flex-col mb-[0.5vh] {$PLAYER && $PLAYER_DATA.cid === message.citizenid ? "text-right items-end -ml-[0.5vh]" : ""}"> -->
                    <div class="w-[45%] flex justify-between items-center text-gray-400 font-medium -mb-[0.5vh]">
                        <p class="text-[1.2vh]">{message.fullname}</p>
                        <p class="text-[1vh] ml-[0.5vh]">{timeAgo(Number(message.time))}</p>
                    </div>
                    <div class="w-[45%] max-w-[45%] mt-[0.5vh] p-[1vh] break-words text-start rounded-lg {$PLAYER && $PLAYER_DATA.cid === message.citizenid ? "bg-accent" : "bg-tertiary"}">
                        <p>{message.message}</p>
                    </div>
                <!-- </div> -->
            {/each}
        {/if}
    </div>

</div>
