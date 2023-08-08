<script>
    import { menuWideStore } from '@store/stores';
</script>

{#if $menuWideStore.isMenuWide}
    <div class="w-[75vh] h-full font-medium border-l-[0.3vh] border-tertiary">
        <div class="flex items-center p-[1.8vh] text-[1.8vh] w-full h-[5.5vh] border-b-[0.3vh] border-tertiary">
            <p>Player</p>
        </div>
    </div>
{/if}

