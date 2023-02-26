<script lang="ts">
  import { fetchNui } from '@utils/fetchNui'

export let selectedAdmincar;
let icon: HTMLElement;


export function toggleSelectionAdmincar(event) {
    selectedAdmincar = !selectedAdmincar;
    event.stopPropagation();
    localStorage.setItem("selectedAdmincar", selectedAdmincar);

  }

  
  function toggleAdmincar() { 
    fetchNui("toggleAdmincar");
    icon.classList.toggle("icon-active")
    if (selectedAdmincar) {
        icon.classList.add('fas');
        icon.classList.remove('far');
    } else {
        icon.classList.remove('far');
        icon.classList.add('fas');
    }
    icon.classList.add("far fa-star")
}

</script>

<button on:click={toggleAdmincar}>
    <i class="icon" bind:this={icon} on:click={toggleSelectionAdmincar} ></i> {'Admin Car'} 
</button>

<style>

button {
    display: flex;
    align-items: center;
}


.icon {
    margin-right: 10px;
    color: var(--textcolor);
}

:global(.icon-active) {
    color: var(--starcolor);
}


</style>