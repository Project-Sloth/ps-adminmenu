<script>
    import { createEventDispatcher } from 'svelte';
    import { slide } from 'svelte/transition';
  
    export let options = [];
    export let selectedOption = '';
    export let searchTerm = '';
  
    function handleInput(event) {
      searchTerm = event.target.value.trim().toLowerCase();
    }
  
    function selectOption(option) {
      selectedOption = option;
      searchTerm = '';
      dispatch('select', { option });
    }
  
    $: filteredOptions = options.filter(option =>
      option.toLowerCase().includes(searchTerm)
    );

    const dispatch = createEventDispatcher();

    $: dispatch('change', { value: selectedOption });


  </script>
  
  <div class="dropdown">
    <input
      class="dropdown-inputs"
      placeholder="ID"
      value={selectedOption}
      on:input={handleInput}
    />
    {#if searchTerm.length > 0}
      <div transition:slide="{{duration: 250}}">
        {#if filteredOptions.length > 0}
          <ul class="select-options">
            {#each filteredOptions as option}
              <li on:click={() => selectOption(option)}>{option}</li>
            {/each}
          </ul>
        {:else}
          <ul class="select-options">
            <li>No results.</li>
          </ul>
        {/if}
      </div>
    {/if}
  </div>


<style>

.dropdown-inputs {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  outline: none;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-top: 0.5rem;
  border-radius: 0.15rem; 
  border: none;
  width: 25rem;
  height: 3.4rem;
}

.select-options {
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  background-color: var(--color-2);
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border-bottom-left-radius: 0.15rem;
  border-bottom-right-radius: 0.15rem;
}

</style>