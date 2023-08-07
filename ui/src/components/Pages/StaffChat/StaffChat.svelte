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
    if (!$menuWideStore.isMenuWide) {
        toggleWideMenu();
    }


    function refreshMsg() {
        SendNUI("GetMessages");

    }
    setInterval(refreshMsg, 1000);
</script>
<div>
    {#if $menuWideStore.isMenuWide}
        <div class="w-[80rem] h-full border-l-2 border-tertiary flex flex-col items-center">

            <div class="flex h-[4vh] w-[95%] justify-center mt-[0.6vh] gap-[0.8vh] items-center">
                <!-- TITLE -->
                <div class="w-full h-[7.5rem] border-b-2 border-tertiary p-8 px-8 font-medium text-[2.2rem]"> Staffchat</div>
            </div>
            <hr class="mt-[1vh] w-[95%] border-border_primary">
            <!-- CHAT -->
            <div class="w-[94%] h-[65vh] mt-[1vh] flex flex-col-reverse overflow-auto">
                {#if $Message && $Messages}
                    {#each $Message.slice().reverse() as message}
                        <div class="w-full flex flex-col mb-[0.5vh] {$PLAYERS && $PLAYERSBUTTONS.cid === message.citizenid ? "text-right items-end -ml-[0.5vh]" : ""}">
                            <div class="w-[45%] flex justify-between items-center text-gray-400 font-medium -mb-[0.5vh]">
                                <p class="text-[1.2vh]">{message.fullname}</p>
                                <p class="text-[1vh] ml-[0.5vh]">{timeAgo(Number(message.time))}</p>
                            </div>
                            <div class="w-[45%] max-w-[45%] mt-2 p-4 break-words text-start rounded-md  border border-border_primary {$PLAYERS && $PLAYERSBUTTONS.cid === message.citizenid ? "bg-accent" : "bg-tertiary"}">
                                <p>{message.message}</p>
                            </div>
                        </div>
                    {/each}
                {/if}
            </div>
            <form on:submit|preventDefault={() => message = message}>
                <div class="w-full h-[6.5rem] bg-primary mt-auto flex items-center">
                    <!-- WRITE MSG -->
                    <input
                        type="text"
                        placeholder='Type your message here...'
                        class="h-[6.5rem] w-[59rem] ml-6 font-medium bg-transparent"
                        bind:value={message}
                    />
                    <button class="hover:bg-tertiary w-[6vh] h-full rounded-r-md border-l border-border_primary" on:click={sendMessage}>
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </form>
        </div>
    {/if}
</div>