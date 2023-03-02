<script lang="ts">
    import { fetchNui } from '@utils/fetchNui';
    import { onMount, onDestroy } from 'svelte';
  
    export let buttonText;
    export let fetchFunction;
    export let id;
  
    let selected = localStorage.getItem(`selected_${id}`) === 'true';
    let icon: HTMLElement;
    let button: HTMLButtonElement;
    let showDropdown = true;
    let dropdown: HTMLElement; 
  
    onMount(() => {
      document.addEventListener('click', handleClickOutside);
    });
  
    onDestroy(() => {
      document.removeEventListener('click', handleClickOutside);
    });
  
    function toggle(event: MouseEvent) {
      const target = event.target as HTMLElement;
      fetchNui(fetchFunction);
      if (target === icon) {
        selected = !selected;
        localStorage.setItem(`selected_${id}`, selected.toString());
      }
      toggleDropdown(); // add this line to open the dropdown
    }

  
    function toggleDropdown() {
      showDropdown = !showDropdown;
      updateDropdownPadding(); // call the function to update the padding
    }
    onMount(() => {
      updateDropdownPadding();
    });
  
    function handleClick(event: MouseEvent) {
      event.stopPropagation();
    }
  
    function handleClickOutside(event: MouseEvent) {
      showDropdown = false;
    }

    function updateDropdownPadding() {
    if (dropdown) {
      const containerHeight = dropdown.querySelector('.dropdown-buttons-container').clientHeight;
      dropdown.style.paddingBottom = `${containerHeight}px`;
    }
  }

  
  </script>
  
  <button on:click={toggle} bind:this={button}>
    <i class={`icon ${selected ? 'icon-selected' : ''} far fa-star ${selected ? 'fas' : 'far'}`} bind:this={icon}></i> {buttonText}
    <i class="fas fa-angle-right dropdown-icon" style="transform: rotate({showDropdown ? 90 : 0}deg);"></i>
  </button>
  
  {#if showDropdown}
  <div class="dropdown" on:click={handleClick} bind:this={dropdown}>
    <slot></slot>
  </div>
  
  {/if}
  
  <style>
  button {
    padding: 1rem;
    width: 100%;
    background-color: var(--color-3);
    color: var(--textcolor);
    font-family: 'Roboto', sans-serif;
    margin-top: 0.5rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .icon {
    margin-right: 1rem;
    margin-top: 3px;
    color: var(--textcolor);
  }
  .icon-selected {
    color: var(--starcolor);
  }
  
  .dropdown-icon {
    margin-left: auto;
    margin-right: 1rem;
  }

  .dropdown {
    background-color: var(--color-3);
    padding-top: 1rem;
    padding-left: 5rem;
    height: 0;
    transition: height 1.5s ease-in-out;
  }

.dropdown-buttons-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
  margin-left: -4rem
}

.dropdown-inputs {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border-radius: 0.15rem; 
  border: none;
  width: 80%;
}

.dropdown-buttons {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border: none;
  width: 30%;
}
  </style>
  