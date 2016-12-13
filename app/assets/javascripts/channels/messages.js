App.messages = App.cable.subscriptions.create(
  "MessagesChannel", {
  connected: function() {
    console.log('MessagesChannel_connected')
  },
  disconnected: function() {
    console.log('MessagesChannel_disconnected')
  },
  received: function(data) {

    // 收到之後要對data幹什麼事情就是在這
  }
});