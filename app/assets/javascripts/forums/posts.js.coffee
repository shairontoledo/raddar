$ ->
  if $('#new_forum_post_content').length > 0
    editor = $('#new_forum_post_content').wysihtml5().data("wysihtml5").editor
    $('.quote_btn').click (e) ->
      content = $(this).closest('.post').find('.post_content').text()
      author = $(this).closest('.post').find('.post_user_name').html()
      editor.focus()
      editor.composer.commands.exec('insertHTML', '<blockquote><p>'+content+'</p><small>'+author+'</small></blockquote>')
