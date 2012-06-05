$('#message_edit_content').removeAttr 'disabled'

$('#new_message_submit').button 'reset'

<% unless @message.errors.any? %>

$('#message_edit_content').val('').focus()
add_chat_message '#chat_<%= @user.id %>', "<%= j render('show', {message: @message, user: @user}) %>"

<% publish_to user_messages_path(@user) do %>

chat = $('#chat_<%= current_user.id %>');

if(chat.length > 0){
  add_chat_message('#chat_<%= current_user.id %>', "<%= j render('show', {message: @message, user: current_user}) %>");
  $.post("<%= read_user_messages_path(current_user) %>");
}else{
  add_message_notification({
    user: '<%= @message.sender.id %>',
    content: "<%= j render 'messages/notification', {message: @message} %>"});
}
<% end %>
<% end %>