window.add_chat_message = (chat_id, content)->
  $(chat_id).append(content).animate({ scrollTop: $('div.chat').prop('scrollHeight') }, 2000)



$ ->
  $('.more_messages_link').live('click',(e)->
    $(this).button('loading')
    )

  $('div.chat').scrollTop($('div.chat').prop('scrollHeight'))

  $('#message_edit_content').keydown((e)->
    if((e.keyCode == 13) && (!e.shiftKey))
      $('form#new_message').submit()
    )

  $('form#new_message').submit((e)->
    if($('#message_edit_content').val() != '')
      $('#message_content').val($('#message_edit_content').val())
      $('#new_message_submit').button('loading')
      $('#message_edit_content').attr('disabled', 'disabled');
    else
      return false
    )

  
  