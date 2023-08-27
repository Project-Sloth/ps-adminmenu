<script>
    export let data
    export let selectedData

    function selectData(label, value) {
        selectedData({
            label: label,
            value: value,
            id: label
        });
    }

    let input = ""

</script>


<div class="w-[22vh] flex flex-col bg-secondary rounded-[0.5vh] border-[0.1vh] border-primary">
    <div class="w-full h-[3.8vh] pl-[1vh] flex justify-between">
        <input 
            type="text" 
            placeholder={data.label} 
            bind:value={input}
            on:input={e => input = e.target.value}
            on:blur={() => selectData(data.label, input)}
            on:click={() => selectData(data.label, input)}
            class="h-full w-[90%] bg-transparent" 
        />
    </div>
</div>