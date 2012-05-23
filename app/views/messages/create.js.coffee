$('#message_edit_content').removeAttr('disabled');
$('#new_message_submit').button('reset')
<% unless @message.errors.any? %>
$('#message_edit_content').val('').focus()
$('div.chat').append("<%= j render('show', {message: @message, user: @user}) %>").animate({ scrollTop: $('div.chat').prop('scrollHeight') }, 2000)
<% publish_to user_messages_path(@user) do %>
chat_id = '#chat_<%= current_user.id %>'
if($(chat_id).length > 0)
  $(chat_id).append("<%= j render('show', {message: @message, user: @user}) %>").animate({ scrollTop: $('div.chat').prop('scrollHeight') }, 2000)
else
  update_messages_notifications(<%= @user.unread_chats.count %>)
<% end %>
<% end %>