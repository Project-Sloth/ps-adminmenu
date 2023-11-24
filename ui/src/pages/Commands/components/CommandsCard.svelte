<script>
	export let label
</script>

<button class="w-full flex justify-between rounded-[0.5vh] bg-tertiary items-center">
    <div class="flex items-center p-[2vh]">
        <i class="fas fa-angle-right mr-[1vh]"></i>
        <p class="text-[1.5vh]">{label ? label : ''}</p>
    </div>
</button>
