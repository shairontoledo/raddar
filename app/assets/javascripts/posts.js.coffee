$ ->
  Bootsy.after 'loaded', ->
    $('.quote_btn').click (e) ->
      content = $(this).closest('.post').find('.post_content').text()
      author = $(this).closest('.post').find('.post_user_name').html()
      Bootsy.editor.focus()
      Bootsy.editor.composer.commands.exec 'insertHTML', '<blockquote><p>'+content+'</p><small>'+author+'</small></blockquote><br/>'
