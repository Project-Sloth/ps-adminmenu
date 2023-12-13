<script>
	import { MENU_WIDE } from '@store/stores'
	import { SendNUI } from '@utils/SendNUI'

	let message = "";

	function sendMessage() {
        if (!message.trim()) return;
        SendNUI("SendMessage", {
            message: message,
        });
		// console.log("Message sent", message)
        message = "";
		setTimeout(() => {
            scrollToBottom();
        }, 100);
    }
	function scrollToBottom() {
        let chatList = document.getElementById("chatList");
        chatList.scroll({
            top: chatList.scrollHeight,
            behavior: 'auto'
        });
    }
</script>

<div
	class="mt-auto w-full h-[4.5vh] rounded-[0.5vh] flex items-center justify-center gap-[1vh] bg-tertiary"
>
	<input
		type="text"
		placeholder="Your message here"
		on:keydown={(e) => {
			if (e.key === "Enter") {
				sendMessage();
			}
		}}
		bind:value={message}
		class="h-full px-[1vh] bg-transparent text-[1.7vh] {$MENU_WIDE ? 'w-[94%]' : 'w-[80%]'}"
	/>
	<button
		class="h-full w-[5vh] rounded-r-[0.5vh] hover:bg-secondary"
		on:click={sendMessage}
	>
		<i class="fas fa-paper-plane text-[1.5vh]" />
	</button>
</div>