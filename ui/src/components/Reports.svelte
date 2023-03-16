<script lang="ts">
  import '../main.css';


  let messageText = '';
  let messages = [];

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
        messages: [] // add a messages property to the new message object
      };

      // Update the messages array with the new message
      messages = [
        ...messages,
        newMessage
      ];

      // Add the new message to the messages array of the selected user
      const selectedUserIndex = messages.findIndex(message => message.header === selectedUser);
      if (selectedUserIndex >= 0) {
        messages[selectedUserIndex].messages = [
          ...messages[selectedUserIndex].messages,
          newMessage
        ];
      }

      // Clear the message input field
      messageText = '';
    }
  }

  function handleKeyUp(event) {
    if (event.keyCode === 13) {
      sendMessage();
      replyToMessage();
    }
  }

  function replyToMessage() {
    if (replyMessageText.trim() !== '') {
      const replyHeader = selectedUser;
      const date = new Date();
      const stringData = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
      const header = 'Admin';
      const replyMessage = {
        header: header,
        text: replyMessageText,
        sent: true,
        timestamp: { time: stringData }
      };
      // Create a new variable with function scope
      let updatedMessages = [...messages];
      const userIndex = messages.findIndex(message => message.header === replyHeader);
      if (updatedMessages[userIndex]) {
        updatedMessages[userIndex].messages = [
          ...(updatedMessages[userIndex].messages || []),
          replyMessage
        ];
      }
      
      // Update the messages array with the new variable
      messages = updatedMessages;
      replyMessageText = '';
    }
  }

  // Default state for the admin UI
  let selectedUser = null;
  let userMessages = [];
  let replyMessageText = '';


  function handleUserSelect(event) {
  selectedUser = event.target.value;
  if (selectedUser === 'you') {
    userMessages = messages;
  } else {
    const userIndex = messages.findIndex(message => message.header === selectedUser);
    if (messages[userIndex]) {
      userMessages = [messages[userIndex], ...messages[userIndex].messages];
      // Check for and include any admin replies to the selected user's messages
      for (let i = 0; i < userMessages.length; i++) {
        if (userMessages[i].header !== 'You' && userMessages[i].header !== selectedUser) {
          userMessages.splice(i, 1);
          i--;
        }
      }
    }
  }
  // Check if the menu is already toggled

}

  // Watch for changes in selectedUser and messages, and update userMessages accordingly
  $: {
  if (selectedUser !== null) {
    const userIndex = messages.findIndex(message => message.header === selectedUser);
    if (messages[userIndex]) {
      userMessages = [messages[userIndex], ...messages[userIndex].messages];
    }
  } else {
    userMessages = [];
  }
}



  let User = true;
</script>

{#if User}
<div class="report-container">
    <div class="report-titlebox">
      <div class="report-title" style="display: flex; justify-content: space-between; margin-right: 15px">
        <span class="material-icons">account_circle</span>
        <span>REPORT: 52</span>
        <span style="" class="material-icons rotate-45">add</span>
      </div>    
    </div>
    <div class="user-message-container">
      {#each userMessages as message}
        <div class="user-message {message.sent ? 'sent' : ''} {message.header === 'You' ? 'user-user-message' : 'user-admin-message'}">
          <div class="message-header">{message.header} - {message.timestamp.time} </div>
          <div class="user-message-text">{message.text}</div>
        </div>
      {/each}
    </div>    
    <div class="input-container">
      <input type="text" id="message-input" bind:value={messageText} placeholder="Type your message here..." on:keyup={handleKeyUp}>
      <button type="submit" id="send-button" on:click={sendMessage}><i class="fas fa-paper-plane"></i></button>
    </div>
  </div>
  {/if}

  <div class="reports">
    <div class="search" style="display: flex; align-items: center; width: 38%;margin-left: 7px;">
      <i style="color:var(--textcolor); margin-right: 10px;" class="fas fa-search"></i>
      <input type="text" style="outline:none;"placeholder="Search..">
    </div>
    
    <div class="admin-container">
      <div class="user-select">
        {#each messages as message}
        <div class="button-with-icon">
          <button type="button" value={message.header} on:click={handleUserSelect}>
            Report

          </button>
          
        </div>
      {/each}
      
      </div>

      <div>
        <span class="admin-input-container2">REPORT: 52</span>
      </div>
      {#if selectedUser === null || selectedUser === ''}
      <div class="admin-nouserselected">
        <i class="material-icons">sentiment_dissatisfied</i>
        <p>You have not selected<br>any report!</p>
      </div>
      {:else}
      {#if selectedUser !== null}
      
      <div class="message-container" id="message-container">
        {#each userMessages as message}
        <div class="user-message {message.sent ? 'sent' : ''} {message.header === 'You' ? 'user-user-message' : 'user-admin-message'}">
          <div class="message-header">{message.header} - {message.timestamp.time}</div>
          <div class="user-message-text">{message.text}</div>
        </div>
      {/each}
      
      </div>
      
        <div class="admin-input-container">
          <input type="text" id="admin-message-input" bind:value={replyMessageText} placeholder="Reply.." on:keyup={handleKeyUp}>
          <button type="submit" id="send-button" on:click={replyToMessage}><i class="fas fa-paper-plane"></i></button>
        </div>
      {/if}
    {/if}

    </div>
  </div>

<style>


.search {
  border-bottom: 2px solid;
  color: var(--textcolor);
}

.search input {
  width: 100%;
  padding: 0.7rem;
  background-color: var(--color-2);
  color: var(--textcolor);
  border: none;
}


.reports {
  flex: 1;
  background-color: var(--color-2);
  padding: 0.8rem;
  height: 100%;
  overflow: hidden;
}

.admin-input-container2 {
  position: fixed;
  bottom: 60rem;
  left: 42.5rem;
  width: 53.2%;
  height: 6%;
  border-radius: 7px;
  background-color: var(--color-1);
  color: var(--textcolor);
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'Roboto';
  font-size: 20px;
}


.admin-input-container {
  position: fixed;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 57%;
  height: 0rem;
  margin-left: 35.6rem;
  margin-bottom: 10px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}


.admin-input-container input {
  flex-grow: 0.9;
  border: none;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  padding: 10px;
  outline: none;
  background-color: var(--color-1);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  margin-bottom: 5rem;
  transition: none; /* remove the transition effect */
}


.admin-input-container button {
  background-color: var(--color-1);
  border: none;
  border-top-right-radius: 10px;
  border-bottom-right-radius: 10px;
  color: var(--textcolor);
  padding: 10px;
  cursor: pointer;
  font-family: 'Roboto', sans-serif;
  margin-bottom: 5rem;
}

.user-messages {
  height: 60rem;
  overflow-x: scroll;
  margin-top: 5rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}


.report-container {
  background-color: var(--color-2);
  width: 400px;
  height: 480px;
  margin: auto;
  position: absolute;
  top: 50%;
  left: -25%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
  border-radius: 10px;
}

.report-titlebox {
  background-color: var(--color-1);
  width: 400px;
  height: 43px;
  position: fixed;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.25);
  border-radius: 10px 10px 0px 0px;
}

.report-title {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 10px;
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  font-size: 20px;
  line-height: 23px;
  text-align: center;
  color: var(--textcolor);
}

.input-container {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 96%;
  height: 0rem;
  margin: 0 auto;
  margin-top: 50px; /* Add margin-top property */
  margin-bottom: 10px;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  border-radius: 10px;
}

.input-container input{
  flex-grow: 0.9;
  border: none;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  padding: 10px;
  outline: none;
  background-color: var(--color-1);
  color: var(--textcolor);
  font-family: 'Roboto', sans-serif;
  margin-bottom: 5rem;
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
  margin-bottom: 5rem;
}

.input-container button i{
  margin-right: 5px;
}

button[type="submit"] :hover {
  color: var(--starcolor);
}

.message-container {
  overflow-y: auto; /* Add a vertical scrollbar */
  height: 52rem;
  display: flex;
  width: 52%;
  flex-direction: column; /* Reverse the order of the child elements */
  margin-left: auto; /* Add margin to the left side */
  margin-right: 3rem;
  margin-top: -5.5rem;
  position: fixed; /* Add fixed position */
  top: 18%; /* Adjust the top position as needed */
  left: 45%; /* Center the container horizontally */

}



.message {
margin-top: 10px;

}

.admin-message {
  display: flex;
  justify-content: flex-end;
}

.admin-message .message-text {
  background-color: #22203380;
  color: var(--textcolor);
  border-radius: 10px;
  padding: 10px;
}

.user-message {
  display: flex;
  justify-content: flex-start;
}

.user-message .message-text {
  background-color: #222033;
  color: var(--textcolor);
  border-radius: 10px;
  padding: 10px;
}

.message-header {
  font-size: 9px;
  color: var(--textcolor);
  margin-bottom: 20px;
  font-family: 'Roboto', sans-serif;
}

.timestamp-container {
  display: flex;
  justify-content: center;
  margin-top: 10px;
}

.user-message-container {
  height: 60rem;
  overflow-x: scroll;
  margin-top: 5rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

.user-admin-message {
  display: flex;
  justify-content: flex-end;
  margin: 10px;
}

.user-admin-message .user-message-text {
  background-color: #22203380;
  color: var(--textcolor);
  border-radius: 10px;
  padding: 10px;
}

.user-user-message {
  display: flex;
  justify-content: flex-start;
  margin: 10px;
}

.user-user-message .user-message-text {
  background-color: #222033;
  color: var(--textcolor);
  border-radius: 10px;
  padding: 10px;
}

.user-select {
  margin-top: 2rem;
}
.user-select button {
  margin-top: 1rem;
  width: 350px;
  height: 51px;
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
  border-radius: 5px;
  margin-left: 7px;
  padding-bottom: 25px;
}

.admin-nouserselected {
  position: fixed;
  right: 20rem;
  top: 18rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #242231;
  font-family: 'Roboto', sans-serif;
  font-size: 20px;
  text-align: center;
}



.admin-nouserselected i {
  font-size: 15rem;
}


</style>