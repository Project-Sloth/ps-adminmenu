<script>

</script>

<div class="settings">
  <div class="search">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input class="search-input" placeholder="Search Settings">
  </div>
  <ul class="settings-ul"> 
    <button class="settings-button">
      <i class="fa-solid fa-signal-stream"></i>
    </button>
  <ul>
</div>

<style>
.settings {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.search {
  border-bottom: 2px solid;
  color: var(--textcolor);
  margin: 4px;
}

.search-input {
  outline:none;
  width: 80%;
  padding: 0.7rem;
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
}

.settings-ul {
  height: 88%;
  overflow-y: scroll;
  padding: 1px;
}

.settings-button {
  height: 4rem;
  width: 100%;
  background-color: var(--color-3);
  border: 1px solid var(--color-3);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  margin-top: 0.5rem;
  cursor: pointer;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  text-align: left;
}

.theme-selector {
  margin-bottom: 1rem;
}

.theme-selector select {
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
  outline: none;
  font-size: 1rem;
  padding: 0.5rem;
}


</style>