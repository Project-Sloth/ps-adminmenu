<script lang="ts">
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
        messages: [] 
      };
      messages = [
        ...messages,
        newMessage
      ];
      messageText = '';
    }
  }
  function handleKeyUp(event) {
    if (event.keyCode === 13) {
      sendMessage();
      replyToMessage();
    }
  }
  
  let selectedUser = "you";
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
    }
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
      
      let updatedMessages = [...messages];
      const userIndex = messages.findIndex(message => message.header === replyHeader);
      if (updatedMessages[userIndex]) {
        updatedMessages[userIndex].messages = [
          ...(updatedMessages[userIndex].messages || []),
          replyMessage
        ];
      }
      
      messages = updatedMessages;
      replyMessageText = '';
    }
  }
  
  $: {
    if (selectedUser !== null) {
      const userIndex = messages.findIndex(message => message.header === selectedUser);
      if (messages[userIndex]) {
        userMessages = [messages[userIndex], ...messages[userIndex].messages];
      }
    }
  }
</script>

<div class="report-container">
    <div class="report-titlebox">
      <div class="report-title" style="display: flex; justify-content: space-between; margin-right: 15px">
        <span class="material-icons">account_circle</span>
        <span>REPORT: 52</span>
        <span style="" class="material-icons rotate-45">add</span>
      </div>    
    </div>
    <div class="user-message-container">
      {#each messages as message}
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

<style>

::-webkit-scrollbar {
  width: 4px;
}
::-webkit-scrollbar-thumb {
  display: none;
}


.report-container {
  background-color: var(--color-2);
  width: 400px;
  height: 480px;
  margin: auto;
  position: absolute;
  top: 50%;
  left: 50%;
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
  color: #C3C3C3;
}

.input-container {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 377px;
  height: 0rem;
  margin: 0 auto;
  margin-top: 50px;
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
  height: 60rem;
  overflow-y: scroll;
  margin-top: 5rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

.message {
  display: flex;
  flex-direction: column;
}

.admin-message {
  display: flex;
  justify-content: flex-start;
  margin: 10px;
  align-items: flex-end;
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
  margin: 10px;
}

.user-message .message-text {
  background-color: #222033;
  color: var(--textcolor);
  border-radius: 10px;
  padding: 10px;
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

.user-message {
  display: flex;
  flex-direction: column;
}


.user-message-container {
  height: 60rem;
  overflow-y: scroll;
  margin-top: 5rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  background-color: blue;
}

.user-admin-message {
  display: flex;
  justify-content: flex-start;
  margin: 10px;
  align-items: flex-end;
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
  width: 15rem;
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
  width: 310px;
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

.button-with-icon {
  position: relative;
}

.button-with-icon i {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  right: 25%;
  color: white;
}

</style>