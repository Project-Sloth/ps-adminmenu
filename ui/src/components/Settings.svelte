<script lang="ts">
    import '../main.css';

</script>

  
<div class="settings">
    <div class="search" style="display: flex; align-items: center;  margin-left: 2px;">
        <i style="color:var(--textcolor); margin-left: 2px;margin-right: 5px;" class="fas fa-search"></i>
        <input type="text" style="outline:none;" placeholder="Search.." >
        </div>
    <ul>

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

.settings ul {
  height: 88%;
  overflow-y: scroll;
  padding: 1px;
}

.settings button{
  padding: 0.8rem;
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

.search {
  border-bottom: 2px solid;
  color: var(--textcolor);
}

.search input {
  width: 50%;
  padding: .7rem;
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
}

.refresh-btn {
  position: absolute;
  top: 4%;
  right: 10px;
  transform: translateY(-50%);
  color: var(--textcolor);
  border: none;
  padding: 10px 15px;
  cursor: pointer;
}

</style>