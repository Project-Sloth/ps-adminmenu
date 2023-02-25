<script lang="ts">
    import '../main.css';
</script>
    
    <div class="playerlist">
        <div class="search" style="display: flex; align-items: center;  margin-left: 2px;">
            <i style="color:var(--textcolor); margin-left: 2px;margin-right: 5px;" class="fas fa-search"></i>
            <input type="text" style="outline:none;" placeholder="Search.." >
          </div>
      </div>

<style>
    
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

.playerlist {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}
    
</style>