<script>
    import {createEventDispatcher} from 'svelte';

    const dispatch = createEventDispatcher();

    export let dropdownValues, label, selectedValue, id="array-dd", insideLabel = "";

    let isOpen = false;

    function toggleDropdown() {
        isOpen = !isOpen;

        const selectWrapper = document.getElementById('select');
        if(isOpen) {
            selectWrapper.style.borderBottomLeftRadius = '0';
            selectWrapper.style.borderBottomRightRadius = '0';
        } else {
            selectWrapper.style.borderBottomLeftRadius = '0.2vw';
            selectWrapper.style.borderBottomRightRadius = '0.2vw';
        }
    }

    function selectDropdownValue(value) {
        selectedValue = value;
        dispatch('selected-dropdown', value);
        isOpen = false;
    }
</script>

<div class="dropdown" id={id}>
    {#if label.trim() !== ''}
        <label for="dd">{label}: </label>
    {/if}
    <div class="dropdown-wrapper">
        <div class="select-wrapper" id="select" on:click={toggleDropdown}>
            {#if selectedValue.trim() !== ''}
                <div class="select-wrapper-selected-value">
                    {#if insideLabel.trim() !== ""}
                        <p class="inside-label">{insideLabel}</p>
                    {/if}
                    <p class="selected-value-text">{selectedValue}</p>
                </div>
            {:else}
                <div></div>
            {/if}
            <i class="fas fa-chevron-down dropdown-chevron"></i>
        </div>
        {#if isOpen}
            <div class="options-wrapper">
                {#if dropdownValues.length < 1}
                    <div class="no-items-found">
                        No items found
                    </div>
                {:else}
                    {#each dropdownValues as ddValue}
                        <div class="option-child" on:click={() => {selectDropdownValue(ddValue)}}>
                            <p>
                                {ddValue}
                                {#if selectedValue === ddValue}
                                    <i class="fas fa-check icon"></i>
                                {/if}
                            </p>
                        </div>
                    {/each}
                {/if}
            </div>
        {/if}
    </div>
</div>

<style>


.dropdown > label {
  margin: 0 0.2vw;
  color: var(--light-text);
}

.dropdown-wrapper {
    display: flex;
    flex-direction: column;

    min-width: 6vw;
    width: fit-content;
    /* padding: 0 0.2vw; */

    background: linear-gradient(0deg, #242424, #242424), linear-gradient(0deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.1));
    border: 1px solid rgba(255, 255, 255, 0.1);

    color: var(--app-name);
    border-radius: 0.2vw;
  }

  .select-wrapper {
    width: auto;
    height: 1.7vw;

    display: flex;
    flex-direction: row;
    justify-content: space-between;
    padding-left: 0.2vw;
    padding-right: 0.3vw;

    cursor: pointer;
  }

  .select-wrapper-selected-value {
    font-size: 0.7vw;
    padding: 0.25vw;
    margin-right: 0.2vw;

    display: flex;
    flex-direction: row;
  }
  .select-wrapper-selected-value > .inside-label {
    color: var(--less-light-border-color);
    margin-right: 0.3vw;
  }
  .select-wrapper-selected-value > .selected-value-text {
    padding-top: 0.05vw;
  }

  .dropdown-chevron {
    text-align: center;
    font-size: 0.5vw;
    margin-top: 0.6vw;

    color: var(--less-light-border-color);
  }

  .options-wrapper {
    width: 100%;
  }

  .options-wrapper > .no-items-found {
    font-size: 0.7vw;
    padding: 0.17vw 0.6vw 0.17vw 0.6vw;
  }

  .option-child {
    cursor: pointer;

    padding: 0.17vw 0.8vw 0.17vw 0.45vw;
    min-height: 1.7vw;
    border-radius: 0.2vw;
    font-size: 0.7vw;
  }

  .option-child > p {
    display: flex;
    flex-direction: row;
  }
  .option-child > p > .icon {
    font-size: 0.65vw;
    padding-top: 0.35vw;
    margin-left: 0.5vw;
  }

  .option-child:hover {
    background-color: var(--black-two-opaque-color);
  }

  /** ARRAY DROPDOWN - end **/
</style>