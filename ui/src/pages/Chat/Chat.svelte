<script>
	import Header from "@components/Header.svelte"
	import SendInput from "./components/SendInput.svelte"
	import RecieveInput from "./components/RecieveInput.svelte"

    let search = "";
</script>

<div class="h-full w-full px-[2vh] pb-[2vh] flex flex-col ">
    <Header title={"Staff Chat"}/>
    <div id='chatList' class="w-full h-[84%] overflow-auto">
        <RecieveInput />
    </div>
    <SendInput />
</div>