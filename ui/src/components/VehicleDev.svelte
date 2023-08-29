<script>
    import { VEHICLE_DEV } from "@store/vehicle_dev"
	import { fly } from "svelte/transition"
</script>

<div class="w-screen h-screen flex items-center">
    <div class="w-[25vh] bg-primary flex flex-col gap-[2vh] rounded-[0.5vh] p-[2vh] ml-[2vh] font-medium" transition:fly={{ x: -100 }}>
        <div class="h-[2vh] w-full flex items-center gap-[1vh] text-[1.5vh]">
            <i class="fas fa-code"></i>
            <p>Vehicle Information</p>
        </div>
        <div>
            <p>Model: {$VEHICLE_DEV?.name}</p>
            <p>Hash: {$VEHICLE_DEV?.model}</p>
            <p>NetID: {$VEHICLE_DEV?.netID}</p>
            <p>Plate: {$VEHICLE_DEV?.plate}</p>
            <p>Fuel: {$VEHICLE_DEV?.fuel}</p>
            <p>Engine: {$VEHICLE_DEV?.engine_health}</p>
            <p>Body: {$VEHICLE_DEV?.body_health}</p>
        </div>
    </div>
</div>