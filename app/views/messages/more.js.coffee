scroll_position = $('#chat').prop('scrollHeight')
$('.more_messages_link').remove()
$('#chat').prepend('<%= j render('chat', {messages: @messages, user: @user}) %>')
scroll_position = $('#chat').prop('scrollHeight') - scroll_position
$('#chat').scrollTop(scroll_position)