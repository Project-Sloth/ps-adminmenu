<script lang="ts">
    import { fetchNui } from '@utils/fetchNui';
  
    export let buttonText;
    export let fetchFunction;
    export let id; 
    
    let selected = localStorage.getItem(`selected_${id}`) === 'true'; 
    let icon: HTMLElement;
    let button: HTMLButtonElement;
  
    function toggle(event: MouseEvent) {
      const target = event.target as HTMLElement;
      fetchNui(fetchFunction);
      if (target === icon) {
        selected = !selected;
        localStorage.setItem(`selected_${id}`, selected.toString()); 
      }
    }
  </script>
  
  <button on:click={toggle} bind:this={button}>
    <i class={`icon ${selected ? 'icon-selected' : ''} far fa-star ${selected ? 'fas' : 'far'}`} bind:this={icon}></i> {buttonText}
  </button>
  
<style>
button {
    padding: 1rem;
    width: 100%;
    background-color: var(--color-3);
    color: var(--textcolor);
    font-family: 'Roboto', sans-serif;
    margin-top: 0.5rem;
    display: flex;
    justify-content: flex-start;
}

.icon {
    margin-right: 1rem;
    margin-top: 3px;
    color: var(--textcolor);
}
.icon-selected {
    color: var(--starcolor);
}
</style>
  