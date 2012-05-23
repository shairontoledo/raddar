scroll_position = $('#chat_<%= @user.id %>').prop('scrollHeight')
$('.more_messages_link').remove()
$('#chat_<%= @user.id %>').prepend('<%= j render('chat', {messages: @messages, user: @user}) %>')
scroll_position = $('#chat_<%= @user.id %>').prop('scrollHeight') - scroll_position
$('#chat_<%= @user.id %>').scrollTop(scroll_position)