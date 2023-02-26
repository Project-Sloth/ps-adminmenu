<script lang="ts">
  import '../main.css';
  import { ReceiveNUI } from '@utils/ReceiveNUI';
  import { SendNUI } from '@utils/SendNUI';
  import { playerStore } from '../store/stores';

  let players = [];

  ReceiveNUI('updatePlayerList', (data) => {
      players = data.players;
      playerStore.set(players);
  });

  function refreshList() {
      playerStore.set([]);
      SendNUI('UpdatePlayerList');
  }

  function handleClick() {
      console.log(players);
  }

  function handleFilterChange(event) {
      const filterText = event.target.value.toLowerCase();
      playerStore.set(players.filter(player => {
          return player.name.toLowerCase().includes(filterText);
      }));
  }
</script>

<div class="server">
  <div class="playerlist">
      <div class="search" style="display: flex; align-items: center;  margin-left: 2px;">
          <i style="color:var(--textcolor); margin-left: 2px;margin-right: 5px;" class="fas fa-search"></i>
          <input type="text" style="outline:none;" placeholder="Search.." on:input={handleFilterChange}>
          <button style="width: 40px;background: none;border: none;" class="refresh-btn" on:click={refreshList}>
              <i class="fa-solid fa-rotate"></i>
          </button>
      </div>
  </div>
  <ul>
      {#each $playerStore as player}
          <button on:click={refreshList}>
              <span>{player.name}</span>
              <div class="resource-buttons">
              </div>
          </button>
      {/each} 
  <ul>
</div>

<style>
  .server {
      flex: 1;
      background-color: var(--color-2);
      padding: 0.8rem;
      height: 100%;
      overflow: hidden;
  }

  .server ul {
      height: 92%;
      overflow-y: scroll;
      padding: 1px;
      margin-top: 1rem;
  }

  .server button{
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
      width: 80%;
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