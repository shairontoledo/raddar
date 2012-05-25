window.update_messages_notifications = (count) ->
  content = ''
  if count > 0
    content = '('+ count + ')'
  $('#messages_notifications_count').html(content) 
  $('#notifications_count').html(content)

$ ->
  update_messages_notifications($('#messages_notifications_count').html())
