$('#message_edit_content').removeAttr('disabled');
$('#new_message_submit').button('reset')
<% unless @message.errors.any? %>
$('#message_edit_content').val('')
$('#chat').append("<%= j render('show', {message: @message, user: @user}) %>")
$('#chat').animate({ scrollTop: $('#chat').prop('scrollHeight') }, 2000)
<% end %>