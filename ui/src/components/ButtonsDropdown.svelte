<script lang="ts">
  import { fetchNui } from '@utils/fetchNui';
  import { onMount, onDestroy } from 'svelte';
  import { afterUpdate } from 'svelte';
  import { slide } from 'svelte/transition';

  export let buttonText;
  export let fetchFunction;
  export let id;

  let selected = localStorage.getItem(`selected_${id}`) === 'true';
  let icon: HTMLElement;
  let button: HTMLButtonElement;
  let showDropdown = false;
  let dropdown: HTMLElement;

  function toggle(event: MouseEvent) {
    const target = event.target as HTMLElement;
    if (target === icon) {
      selected = !selected;
      localStorage.setItem(`selected_${id}`, selected.toString());
    }
    toggleDropdown();
  }

  function toggleDropdown() {
    showDropdown = !showDropdown;
  }

  function handleClick(event: MouseEvent) {
    event.stopPropagation();
  }



</script>

<button on:click={toggle} bind:this={button}>
  <i class={`icon ${selected ? 'icon-selected' : ''} far fa-star ${selected ? 'fas' : 'far'}`} bind:this={icon}></i> {buttonText}
  <i class="fas fa-angle-right dropdown-icon" style="transform: rotate({showDropdown ? 90 : 0}deg);"></i>
</button>

{#if showDropdown}
<div class="dropdown" on:click={handleClick} bind:this={dropdown} transition:slide="{{duration: 300}}">
  <div class="dropdown-buttons-container">
    <slot></slot>
  </div>
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
    color: var(--textcolor);
  }

  .icon-selected {
    color: var(--starcolor);
  }

  .dropdown-icon {
    margin-left: auto;
    margin-right: 1rem;
    transition: transform 0.3s ease;
  }

  .dropdown {
    background-color: var(--color-3);
    padding-left: 9rem;
    padding-bottom: 0.5rem;
    height: auto;
    transition: height 1.5s ease-in-out;
    overflow: hidden;
  }

  .dropdown-buttons-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
    margin-left: -4rem;
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
  