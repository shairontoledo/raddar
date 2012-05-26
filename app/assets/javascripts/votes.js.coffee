$ ->
  $('a.voted').button('toggle')
  
  $('a.vote').click (e) ->
    if !$(this).hasClass('disabled')
      count =  parseInt($(this).children('.counter').html())
      $(this).children('.counter').html(count+1)
      count =  parseInt($(this).parent().children('.voted').children('.counter').html())
      $(this).parent().children('.voted').removeClass('voted').children('.counter').html(count-1)
      $(this).addClass('voted')
