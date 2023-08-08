<script>
import {toggleWideMenu, menuWideStore, PLAYERS, PLAYERSBUTTONS, Message, Messages } from '@store/stores';
    import { SendNUI } from "@utils/SendNUI"
    import { timeAgo } from "@utils/timeAgo"

    let message = "";

    function sendMessage() {
        if (!message.trim()) return;
        SendNUI("SendMessage", {
            message: message,
        });
        message = "";
    }

    // if (!$menuWideStore.isMenuWide) {
    //     toggleWideMenu();
    // }

    function refreshMsg() {
        SendNUI("GetMessages");
    }

    setInterval(refreshMsg, 1000);
</script>

<div class="h-full font-medium flex flex-col items-center {$menuWideStore.isMenuWide ? "w-[114vh] " : "w-[39vh]" }">
    <div class="flex items-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
        <p>Staff Chat</p>
    </div>
    <div class="h-[75vh] my-[1vh] text-[1.8vh] flex flex-col-reverse overflow-auto {$menuWideStore.isMenuWide ? "w-[98%]" : "w-[95%]"}">
        {#if $Message && $Messages}
            {#each $Message.slice().reverse() as message}
                <div class="w-full flex flex-col mb-[0.5vh] {$PLAYERS && $PLAYERSBUTTONS.cid === message.citizenid ? "text-right items-end -ml-[0.5vh]" : ""}">
                    <div class="w-[45%] flex justify-between items-center text-gray-400 font-medium -mb-[0.5vh]">
                        <p class="text-[1.2vh]">{message.fullname}</p>
                        <p class="text-[1vh] ml-[0.5vh]">{timeAgo(Number(message.time))}</p>
                    </div>
                    <div class="w-[45%] max-w-[45%] mt-[0.5vh] p-[1vh] break-words text-start rounded-lg {$PLAYERS && $PLAYERSBUTTONS.cid === message.citizenid ? "bg-accent" : "bg-tertiary"}">
                        <p>{message.message}</p>
                    </div>
                </div>
            {/each}
        {/if}
    </div>
    <form class="w-full flex justify-center" on:submit|preventDefault={() => message = message}>
        <div class="h-[6.5rem] bg-primary mb-[1vh] mt-auto flex items-center font-medium {$menuWideStore.isMenuWide ? "w-[98%]" : "w-[95%]"}">
            <input
                type="text"
                placeholder='Type your message here...'
                class="h-[4vh] w-full p-[1.5vh] bg-transparent"
                bind:value={message}
            />
            <button class="bg-tertiary w-[10vh] h-full" on:click={sendMessage}>
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </form>
</div>

