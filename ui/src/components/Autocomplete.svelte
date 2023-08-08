<script>
    let inputValue = '';
    const options = ['Option 1', 'Option 2', 'Option 3'];
  
    function handleInput(event) {
      inputValue = event.target.value;
    }
  
    function filterOptions() {
      return options.filter(option => option.toLowerCase().includes(inputValue.toLowerCase()));
    }
  </script>
  
  <input type="text" value={inputValue} list="autocomplete-list" on:keyup={filterOptions} on:input={handleInput}>
  <datalist id="autocomplete-list">
    {#each filterOptions() as option}
      <option value={option}>
    {/each}
  </datalist>
  