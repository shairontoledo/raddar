$ ->
  $('.more_messages_link').live('click',(e)->
    $(this).button('loading')
    )

  $('#chat').scrollTop($('#chat').prop('scrollHeight'))

  $('form#new_message').submit((e)->
    if($('#message_edit_content').val() != '')
      $('#message_content').val($('#message_edit_content').val())
      $('#new_message_submit').button('loading')
      $('#message_edit_content').attr('disabled', 'disabled');
    else
      return false
    )

  
  