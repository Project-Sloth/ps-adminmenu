<script>
	import { slide } from "svelte/transition"

    export let label

    let DataDropdownActive = false

    let data = [
        {
            label: 'Test',
            type: 'input',
            inputtype: 'text',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
        {
            label: 'Test',
            type: 'button',
            event: 'test',
        },
    ]
</script>

<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh]">
    <div class="w-full h-[3.8vh] pl-[1vh] flex justify-between">
        <input 
            type="text" 
            placeholder={label} 
            on:focus={() => (DataDropdownActive = true)} 
            on:blur={() => (DataDropdownActive = false)}
            class="h-full w-[90%] bg-transparent" 
        />
    </div>

    {#if DataDropdownActive}
        <div 
            class="w-full rounded-b-[0.5vh] flex flex-col max-h-[15vh] overflow-y-auto border-t border-primary scroll-visble"
            transition:slide={{ duration: 150 }}
        >
            {#each data as item}
                <button class="w-full p-[0.5vh] flex justify-start px-[1vh] hover:bg-tertiary">
                    <p class="">{item.label}</p>
                </button>
            {/each}
        </div>
    {/if}
</div>

