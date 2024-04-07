import consumer from "./consumer"

consumer.subscriptions.create("MessagesChannel", {
  connected() {
    console.log('Connected to the WebSocket server. Real-time updates are enabled.');
  },

  received(data) {
    const messagesContainer = document.getElementById('messages');

    const messageContent = `<p>${data['body']}</p>`;
    const messageContainer = data['sent_by_coach'] ? '<div class="container-coach">' + messageContent + '</div>' : '<div class="container-user">' + messageContent + '</div>';

    messagesContainer.insertAdjacentHTML('beforeend', messageContainer); 
    messagesContainer.scrollTop = messagesContainer.scrollHeight;

    const messageInput = document.getElementById('textMessage');
    messageInput.value = '';

    const sendButton = document.getElementById('sendButton');
    sendButton.disabled = false;
  }
});