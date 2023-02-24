<script lang="ts">
    import '../main.css';
    import { fetchNui } from '@utils/fetchNui'

  let resources = [];
  let isMenuLarge = false;
  let isMenuHidden = false;
  let DevMode = false;
  let DebugMode = false;
  let showThemes = false;
  let currentPage = 'wizard';
  let searchTerm = "";
  let showDropdownAdmincar = false;
  let showDropdownBanplayer = false;
  let showDropdownBringplayer = false;
  let showDropdownKickplayer = false;
  let showDropdownTeleportCoords = false;
  let showThemesDropdown = false;

  let selectedAdmincar = localStorage.getItem("selectedAdmincar") === "true" || false;
  let selectedBanplayer = localStorage.getItem("selectedBanplayer") === "true" || false;
  let selectedBringplayer = localStorage.getItem("selectedBringplayer") === "true" || false;
  let selectedClothing = localStorage.getItem("selectedClothing") === "true" || false;
  let selectedNoclip = localStorage.getItem("selectedNoclip") === "true" || false;
  let selectedInvisible = localStorage.getItem("selectedInvisible") === "true" || false;
  let selectedKickplayer = localStorage.getItem("selectedKickplayer") === "true" || false;
  let selectedTeleportCoords = localStorage.getItem("selectedTeleportCoords") === "true" || false;
  let selectedThemes = localStorage.getItem("selectedThemes") === "true" || false;

  function toggleMenu() {
    isMenuLarge = !isMenuLarge;
  }

  function showSettings() {
    currentPage = 'settings';
  }

  function showWizard() {
    currentPage = 'wizard';
  }

  function showList() {
    currentPage = 'list';
  }

  function showServer() {
    currentPage = 'server';
  }

  function showReports() {
    currentPage = 'reports';
  }

  function toggleDevMode() {
    DevMode = !DevMode;
    fetchNui("ToggleDevMode");
  }

  function ToggleDebug() {
    DebugMode = !DebugMode;
    fetchNui("ToggleDebugMode");
  }

  function OpenThemesMenu() {
    showThemes = !showThemes;
  }

  function toggleThemes() {
    showThemes = !showThemes;
  }

  function setSearchTerm(event) {
    searchTerm = event.target.value.toLowerCase();
  }

  function toggleDropdownAdmincar() {
    showDropdownAdmincar = !showDropdownAdmincar;
  }

  function toggleDropdownBanplayer() {
    showDropdownBanplayer = !showDropdownBanplayer;
  }

  function toggleDropdownKickplayer() {
    showDropdownKickplayer = !showDropdownKickplayer;
  }

  function toggleDropdownBringplayer() {
    showDropdownBringplayer = !showDropdownBringplayer;
  }

  function toggleDropdownTeleportCoords() {
    showDropdownTeleportCoords = !showDropdownTeleportCoords;
  }

  function toggleThemesDropdown() {
    showThemesDropdown = !showThemesDropdown;
  }

  function toggleSelectionAdmincar(event) {
    selectedAdmincar = !selectedAdmincar;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedAdmincar", selectedAdmincar);
  }

  function toggleSelectionBanplayer(event) {
    selectedBanplayer = !selectedBanplayer;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedBanplayer", selectedBanplayer);
  }

  function toggleSelectionBringplayer(event) {
    selectedBringplayer = !selectedBringplayer;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedBringplayer", selectedBringplayer);
  }

  function toggleSelectionClothing(event) {
    selectedClothing = !selectedClothing;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedClothing", selectedClothing);
  }
  function toggleSelectionNoclip(event) {
    selectedNoclip = !selectedNoclip;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedNoclip", selectedNoclip);
  }
  function toggleSelectionInvisible(event) {
    selectedInvisible = !selectedInvisible;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedInvisible", selectedInvisible);
  }
  function toggleSelectionKickplayer(event) {
    selectedKickplayer = !selectedKickplayer;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedKickplayer", selectedKickplayer);
  }
  function toggleSelectionTeleportCoords(event) {
    selectedTeleportCoords = !selectedTeleportCoords;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedTeleportCoords", selectedTeleportCoords);
  }

  function toggleSelectionThemes(event) {
    selectedThemes = !selectedThemes;
    event.stopPropagation();
    // Save the state of the star to the localStorage
    localStorage.setItem("selectedThemes", selectedThemes);
  }

  function toggleNoclip() {
    fetchNui("ToggleNoClip");
  }
  function toggleInvis() {
    fetchNui("ToggleInvis");
  }
  function toggleClothing() {
    fetchNui("ToggleClothing");
    visibility.set(false);
    fetchNui("hideUI");
  }
  function toggleAdmincar() {
    fetchNui("toggleAdmincar");
  }

  let showAll = true;
  let showFavorites = false;

  function toggleAll() {
    showAll = true;
    showFavorites = false;
  }

  function toggleFavorites() {
    showAll = false;
    showFavorites = true;
  }

function banPlayer() {
  const idInput = document.querySelector('input[placeholder="ID"]');
  const reasonInput = document.querySelector('input[placeholder="Reason"]');
  const timeInput = document.querySelector('input[placeholder="Length"]');

  const player = idInput.value;
  const reason = reasonInput.value;
  const time = timeInput.value;

  // Send the ban request to the server using fetchNui
  fetchNui('banPlayer', { player, reason, time });
  console.log(player, reason, time);
}

// Resource List
// ReceiveNUI('updateResourceList', (data) => {
//   resources = data.resources;
//   $resourceStore = resources;
// });


function refreshList() {
  SendNUI('UpdateResourceList')
  console.log("UpdateResourceList");
}
function handleClick() {
  console.log(resources);
}

// function handleFilterChange(event) {
//   const filterText = event.target.value.toLowerCase();
//   $resourceStore = resources.filter(resource => {
//     return resource.name.toLowerCase().includes(filterText);
//   });
// }
// Resource List End

let messageText = '';
let replyMessageText = '';
let messages = [];
let selectedUser = null;
let usersWithMessages = [];
let userMessages = [];


function sendMessage() {
  if (messageText.trim() !== '') {
    const date = new Date();
    const stringData = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    const header = 'You';
    const newMessage = {
      header: header,
      text: messageText,
      sent: true,
      timestamp: { time: stringData },
    };
    
    if (selectedUser && selectedUser !== 'Admin') {
      const userIndex = messages.findIndex(message => message.header === selectedUser);
      if (messages[userIndex]) {
        if (!messages[userIndex].messages) {
          messages[userIndex].messages = [];
        }
        messages[userIndex].messages.push(newMessage);
      }
    } else {
      messages.push(newMessage);
    }
    
    messageText = '';
    
    // populate usersWithMessages array with updated messages
    usersWithMessages = messages.filter(message => message.header !== 'Admin' && messages.some(m => m.header === message.header));
  }
  renderMessages();
}



function replyToMessage() {
  console.log(replyMessageText)
  if (replyMessageText.trim() !== '' && selectedUser !== null) {
    const replyHeader = selectedUser;
    const date = new Date();
    const stringData = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    const header = 'Admin';

    const replyMessage = {
      header: header,
      text: replyMessageText,
      sent: true,
      timestamp: { time: stringData },
    };

    // find the user's message array and add the reply message to it
    const userIndex = messages.findIndex(message => message.header === replyHeader);
    if (messages[userIndex]) {
      if (!messages[userIndex].messages) {
        messages[userIndex].messages = [];
      }
      messages[userIndex].messages.push(replyMessage);
    }

    replyMessageText = '';

    // populate usersWithMessages array with updated messages
    usersWithMessages = messages.filter(message => message.header !== 'Admin' && messages.some(m => m.header === message.header));
  }
  renderMessages();
}

function handleUserSelect(event) {
  selectedUser = event.target.value;
  if (selectedUser === 'Admin') {
    userMessages = messages;
    console.log(userMessages)
  } else {
    const userMessagesList = [];
    usersWithMessages.forEach(message => {
      if (message.header === selectedUser || message.header === 'Admin') {
        userMessagesList.push(message);
        if (message.messages) {
          message.messages.forEach(reply => userMessagesList.push(reply));
        }
      }
      console.log(selectedUser)
    });
    userMessages = userMessagesList;
  }
  renderMessages();
}

function handleKeyUp(event) {
  if (event.keyCode === 13 && event.target.id === 'message-input') {
    sendMessage();
  } else if (event.keyCode === 13 && event.target.id === 'admin-message-input') {
    replyToMessage();
  }
}

function renderMessages() {
  const messageContainer = document.getElementById('message-container');
  messageContainer.innerHTML = '';

  userMessages.forEach(message => {
    const messageElement = document.createElement('div');
    messageElement.classList.add('message');
    messageElement.classList.add(message.sent ? 'sent' : 'received');

    const headerElement = document.createElement('div');
    headerElement.classList.add('header');
    headerElement.innerText = message.header;

    const textElement = document.createElement('div');
    textElement.classList.add('text');
    textElement.innerText = message.text;

    const timestampElement = document.createElement('div');
    timestampElement.classList.add('timestamp');
    timestampElement.innerText = message.timestamp.time;

    messageElement.appendChild(headerElement);
    messageElement.appendChild(textElement);
    messageElement.appendChild(timestampElement);

    messageContainer.appendChild(messageElement);

    if (message.messages) {
      message.messages.forEach(reply => {
        const replyElement = document.createElement('div');
        replyElement.classList.add('reply');
        replyElement.classList.add(reply.sent ? 'sent' : 'received');

        const replyHeaderElement = document.createElement('div');
        replyHeaderElement.classList.add('header');
        replyHeaderElement.innerText = reply.header;

        const replyTextElement = document.createElement('div');
        replyTextElement.classList.add('text');
        replyTextElement.innerText = reply.text;

        const replyTimestampElement = document.createElement('div');
        replyTimestampElement.classList.add('timestamp');
        replyTimestampElement.innerText = reply.timestamp.time;

        replyElement.appendChild(replyHeaderElement);
        replyElement.appendChild(replyTextElement);
        replyElement.appendChild(replyTimestampElement);

        messageContainer.appendChild(replyElement);
      });
    }
  });
}

</script>

<div class="container {isMenuLarge ? 'open' : ''}">
    <div class="sidebar">
      <button on:click={showSettings} aria-label="Settings" style="margin-bottom: 0.7rem;">
        <i class="fas fa-gear"></i>
      </button>
      <button on:click={toggleDevMode} style="color: {DevMode ? 'var(--starcolor)' : 'var(--textcolor)'}" aria-label="Dev Mode">
        <i class="fas fa-terminal"></i>
      </button>
      <button on:click={showWizard} aria-label="Wizard">
        <i class="fas fa-hat-wizard"></i>
      </button>
      <button on:click={showList} aria-label="List">
        <i class="fas fa-list"></i>
      </button>
      <button on:click={showServer} aria-label="Server">
        <i class="fas fa-server"></i>
      </button>
      <button on:click={showReports} aria-label="Reports">
        <i class="fas fa-message"></i>
      </button>
      <button on:click={toggleMenu}>
        <i class="fas fa-angle-left" id="icon" style="margin-bottom: 36.6rem;transform: rotate({isMenuLarge ? 180 : 0}deg);"></i>
      </button>
    </div>
  
  
      <!-- Main page -->
  {#if currentPage === 'wizard'}
    <div class="menu">
      <div class="button-container" style="display: flex; justify-content: flex-start; align-items: center; margin-top: -4.5px; margin-left: 5px;">
        <button style="border: none; background-color: var(--color-2); width: 40px; height: 35px; text-align: center; vertical-align: middle;" on:click={() => {showFavorites = false}} on:keydown={e => {if(e.key === 'Enter') {}}}>All</button>
        <button style="border: none; background-color: var(--color-2); margin-left: 5px;width: 75px; height: 35px; text-align: center; vertical-align: middle;" on:click={() => {showFavorites = true}} on:keydown={e => {if(e.key === 'Enter') {}}}>Favorites</button>
        </div>      
        <div class="search">
          <input type="text" placeholder="Begin typing to filter commands"  style="outline: none;">
        </div>
        <ul>
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Admin Car'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedAdmincar)}
          <button style="display: flex; align-items: center;" on:click={toggleAdmincar}>
            <i class={`far fa-star ${selectedAdmincar ? 'fas' : 'far'}`} on:click={toggleSelectionAdmincar} style="margin-right: 10px; color: {selectedAdmincar ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Admin Car'} 
          </button>
        {/if}
      
          
          {#if (searchTerm === '' || 'Ban Player'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedBanplayer)}
          <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownBanplayer}>
            <i class={`far fa-star ${selectedBanplayer ? 'fas' : 'far'}`} on:click={toggleSelectionBanplayer} style="margin-right: 10px; color: {selectedBanplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Ban Player'} 
            <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownBanplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
          </button>
                
          {#if showDropdownBanplayer}
          <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 1rem;height: -20px; overflow: hidden; transition: height 1.5s ease-in-out;">
            <!-- Your dropdown menu content goes here -->
            <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
              <input type="text" placeholder="ID" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
              <input type="text" placeholder="Reason" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
              <input type="text" placeholder="Length" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
              <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Ban</button>
            </div>
          </div>
          {/if}
        {/if}
  
          {#if (searchTerm === '' || 'Bring Player'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedBringplayer)}
          <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownBringplayer}>
            <i class={`far fa-star ${selectedBringplayer ? 'fas' : 'far'}`} on:click={toggleSelectionBringplayer} style="margin-right: 10px; color: {selectedBringplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Bring Player'} 
            <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownBringplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
          </button>
        
          {#if showDropdownBringplayer}
          <div style="background-color: var(--color-3);padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 4.7rem; height: 0px; overflow: hidden; transition: height 1.5s ease-in-out;">
              <!-- Your dropdown menu content goes here -->
              <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
                <input type="text" placeholder="ID" style="color: var(--textcolor);font-family: 'Roboto', sans-serif;outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
                <button style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Submit</button>
              </div>
              
            </div>
          {/if}
        {/if}
  
          <!-- Click Button-->
          {#if (searchTerm === '' || 'Clothing Menu'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedClothing)}
          <button style="display: flex; align-items: center;" on:click={toggleClothing}>
            <i class={`far fa-star ${selectedClothing ? 'fas' : 'far'}`} on:click={toggleSelectionClothing} style="margin-right: 10px; color: {selectedClothing ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Clothing Menu'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Customs'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Customs'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Change Weather'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Change Weather'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Fix Vehicle'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Fix Vehicle'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'God'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'God'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Give Cash'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give Cash'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Give Item'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give Item'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Give License'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Give License'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Invisible'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedInvisible)}
          <button style="display: flex; align-items: center;" on:click={toggleInvis}>
            <i class={`far fa-star ${selectedInvisible ? 'fas' : 'far'}`} on:click={toggleSelectionInvisible} style="margin-right: 10px; color: {selectedInvisible ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Invisible'} 
          </button>
        {/if}
  
        {#if (searchTerm === '' || 'Kick'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedKickplayer)}
        <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownKickplayer}>
          <i class={`far fa-star ${selectedKickplayer ? 'fas' : 'far'}`} on:click={toggleSelectionKickplayer} style="margin-right: 10px; color: {selectedKickplayer ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Kick'} 
          <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownKickplayer ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
        </button>
              
        {#if showDropdownKickplayer}
        <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 8.5rem;height: 0px; overflow: hidden; transition: height 1.5s ease-in-out;">
          <!-- Your dropdown menu content goes here -->
          <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
            <input type="text" placeholder="ID" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <input type="text" placeholder="Reason" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Kick</button>
          </div>
        </div>
        {/if}
      {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Noclip'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Noclip'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Revive'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Revive'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Revive in Radius'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Revive in Radius'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Spawn Car'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Spawn Car'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Teleport'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport'} 
          </button>
        {/if}
  
        <!-- Click Button-->
  
        {#if (searchTerm === '' || 'Teleport Coords'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedTeleportCoords)}
        <button style="display: flex; justify-content: space-between;" on:click={toggleDropdownTeleportCoords}>
          <i class={`far fa-star ${selectedTeleportCoords ? 'fas' : 'far'}`} on:click={toggleSelectionTeleportCoords} style="margin-right: 10px; color: {selectedTeleportCoords ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport Coords'} 
          <i class="fas fa-angle-right" id="themes-icon" style="margin-left: auto; margin-right: 7px; transform: rotate({showDropdownTeleportCoords ? 90 : 0}deg); transition: height 0.5s ease-in-out;"></i>
        </button>
              
        {#if showDropdownTeleportCoords}
        <div style="background-color: var(--color-3); padding-top: 5rem;padding-left: 5rem;padding-right: 5rem;padding-bottom: 4.5rem;height: 27px; overflow: hidden; transition: height 1.5s ease-in-out;">
          <!-- Your dropdown menu content goes here -->
          <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-top: -4rem; margin-left: -4rem">
            <input type="text" placeholder="Coords" style="font-family: 'Roboto', sans-serif;color: var(--textcolor);outline: none;background-color: var(--color-2);padding: 0.5rem; margin-bottom: 0.5rem; border-radius: 0.15rem; border: none;">
            <button on:click={banPlayer} style="padding: 0.5rem; border-radius: 0.15rem; border: none; background-color: var(--color-2); color: var(--textcolor);font-family: 'Roboto', sans-serif;">Teleport</button>
          </div>
        </div>
        {/if}
      {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Teleport Marker'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Teleport Marker'} 
          </button>
        {/if}
  
        <!-- Click Button-->
        {#if (searchTerm === '' || 'Unban'.toLowerCase().includes(searchTerm)) && (!showFavorites || selectedNoclip)}
          <button style="display: flex; align-items: center;" on:click={toggleNoclip}>
            <i class={`far fa-star ${selectedNoclip ? 'fas' : 'far'}`} on:click={toggleSelectionNoclip} style="margin-right: 10px; color: {selectedNoclip ? 'var(--starcolor)' : 'var(--textcolor)'}"></i> {'Unban'} 
          </button>
        {/if}
  
      </ul>
    </div>
  
  {:else if currentPage === 'settings'}
    
  <div class="settings">
    <div class="search">
      <input type="text" placeholder="Begin typing to filter settings" style="outline: none;">
    </div>
    
  </div>
  
  {:else if currentPage === 'server'}
  
  <div class="server">
    <div class="searchRes">
      <!-- <input type="text" placeholder="Begin typing to filter resources" style="outline: none;" on:input={handleFilterChange}> -->
      <button style="width: 40px;background: none;border: none;" class="refresh-btn" on:click={refreshList}>
        <i class="fa-solid fa-rotate"></i>
      </button>
    </div>
    <ul>
      <!-- {#each $resourceStore as resource}
      <button on:click={handleClick}>
        <span>{resource.name}</span>
        <div class="resource-buttons">
          <button class="button1">Button 1</button>
          <button class="button2">Button 2</button>
        </div>
      </button>
    {/each} -->
    
    <ul>
  </div>
  
  
  {:else if currentPage === 'reports'}
  
  <div class="reports">
    <div class="search">
      <input type="text" placeholder="Begin typing to filter reports" style="outline: none;">
    </div>
    
  
    <div class="admin-container">
      <div class="user-select">
        <select on:change={handleUserSelect}>
          <option value="" selected disabled>Select a user...</option>
          {#each usersWithMessages as message}
            <option value={message.header}>{message.header}</option>
          {/each}
        </select>
        
      </div>
      {#if selectedUser !== null}
        <div class="user-messages">
          {#each userMessages as message}
            <div class="message {message.sent ? 'sent' : ''}">
              <div class="message-header">{message.header} - {message.timestamp.time}</div>
              <div class="message-text">{message.text}</div>
            </div>
          {/each}
        </div>
        <div class="admin-input-container">
          <input type="text" id="admin-message-input" bind:value={replyMessageText} placeholder="Reply to the message here..." on:keyup={handleKeyUp}>
          <button type="submit" id="send-button" on:click={replyToMessage}><i class="fas fa-paper-plane"></i></button>
        </div>
      {/if}
    </div>
  
  </div>
  
  {:else if currentPage === 'list'}
  
  <div class="playerlist">
    <div class="search">
      <input type="text" placeholder="Begin typing to filter players" style="outline: none;">
    </div>
  </div>
  
  {/if}
  
  </div>

  <style>

::-webkit-scrollbar {
  width: 4px;
}
::-webkit-scrollbar-thumb {
  display: none;
}

.container {
  display: flex;
  position: fixed;
  top: 50%;
  right: 2%;
  transform: translateY(-50%);
  width: 22%;
  height: 650px;
  transition: all 0.7s ease;
  background-color: var(--color-1);

}

.container.open {
  right: 0%;
  transform: translate(-50%, -50%);
  width: 50%;

}

.sidebar {
  background-color: var(--color-1);
  padding: 1.2rem;
  height: 100%;
  display: flex;
  flex-direction: column-reverse;
}

.sidebar button {
  display: block;
  margin-top: 1.5rem;
  background-color: transparent;
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  border: none;
  cursor: pointer;
}

.search input {
  width: 100%;
  padding: 0.7rem;
  background-color: var(--color-2);
  color: aliceblue;
  border: none;
  border-bottom: 1px solid var(--textcolor);
}

.searchRes input {
  width: 90%;
  padding: 0.7rem;
  background-color: var(--color-2);
  color: aliceblue;
  border: none;
  border-bottom: 1px solid var(--textcolor);
}

.refresh-btn {
  position: absolute;
  top: 4%;
  right: 10px;
  transform: translateY(-50%);
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
}
  
.menu {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.menu ul {
  margin-top: 10px;
  height: 87%;
  overflow-y: scroll;
  padding: 1px;
}

.menu button {
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

.settings {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.settings ul {
  height: 93%;
  overflow-y: scroll;
  padding: 1px;
}

.settings button {
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

.server {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.server ul {
  height: 88%;
  overflow-y: scroll;
  padding: 1px;
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

.playerlist {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.reports {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.report-container {
  background-color: var(--color-2);
  width: 25rem;
  height: 30rem;
  margin: auto;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
}

.report-titlebox {
  background-color: var(--color-1);
  width: 25rem;
  height: 2.3rem;
  position: fixed;
  border-bottom: solid 0.1px rgb(92, 92, 92);
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
}

.report-title {
  margin: 10px;
  margin-left: 15px;
  font-size: large;
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
}

.input-container {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 95%;
  margin: 0 auto;
  margin-bottom: 10px;
}

.input-container input{
  flex-grow: 1;
  border: none;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  padding: 10px;
  outline: none;
  background-color: var(--color-1);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
}

.input-container button{
  background-color: var(--color-1);
  border: none;
  border-top-right-radius: 10px;
  border-bottom-right-radius: 10px;
  color: var(--textcolor);
  padding: 10px;
  cursor: pointer;
  font-family: 'Roboto', sans-serif;
}

.input-container button i{
  margin-right: 5px;
}

button[type="submit"] :hover {
  color: var(--starcolor);
}

.message-container {
  height: 25rem;
  overflow-x: scroll;
  margin-top: 3rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end; /* add this line */
}

.message {
  display: flex;
  flex-direction: column;
}

.message-text {
  color: white;
  background-color: var(--color-1);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  padding: 10px;
  border-radius: 8px;
  width: fit-content;
  align-items: flex-start;
  margin-bottom: 10px;
}

.message.sent {
  align-self: flex-end;
  margin-left: auto;
  margin-right: 10px;
  align-items: flex-end; /* change this line */
  font-family: 'Roboto', sans-serif;
}

.message-header {
  font-size: 9px;
  color: rgb(179, 179, 179);
  margin-bottom: 5px;
  font-family: 'Roboto', sans-serif;
}

.timestamp-container {
  display: flex;
  justify-content: center;
  margin-top: 10px;
}
  </style>