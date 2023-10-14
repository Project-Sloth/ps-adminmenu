<script>
    import { TOGGLE_COORDS } from "@store/togglecoords"
	import { fly } from "svelte/transition"
</script>

<div class="w-screen h-screen flex items-center">
    <div class="w-[25vh] bg-primary flex flex-col gap-[2vh] rounded-[0.5vh] p-[2vh] ml-[2vh] font-medium" transition:fly={{ x: -100 }}>
        <div class="h-[2vh] w-full flex items-center gap-[1vh] text-[1.5vh]">
            <i class="fas fa-code"></i>
            <p>Coords Information</p>
        </div>
        <div>
            <p>X: {$TOGGLE_COORDS?.x}</p>
            <p>Y: {$TOGGLE_COORDS?.y}</p>
            <p>Z: {$TOGGLE_COORDS?.z}</p>
            <p>Heading: {$TOGGLE_COORDS?.heading}</p>
        </div>
    </div>
</div>