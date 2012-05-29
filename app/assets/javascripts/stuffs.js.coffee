$ ->
  if $('#stuff_content').length > 0
    editor = $('#stuff_content').wysihtml5().data("wysihtml5").editor
    editor.on("change", confirm_unload)