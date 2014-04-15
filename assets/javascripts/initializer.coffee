$ ->



  $('#models').bxSlider({
    nextSelector: '#next-model',
    prevSelector: '#prev-model',
    nextText: "<img src='/images/right_arrow.png'>",
    prevText: "<img src='/images/left_arrow.png'>",
    pagerCustom: '#models-pager',
    onSlideBefore: (el, oldIndex, newIndex) ->
      $('#models-pager li').removeClass('active')
      $($('#models-pager li')[newIndex]).addClass('active')
  });


  $('#samples').bxSlider({
    nextSelector: '#next-sample',
    prevSelector: '#prev-sample',
    nextText: "<img src='/images/right_arrow.png'>",
    prevText: "<img src='/images/left_arrow.png'>",
    pager: false
  });


  $('.show-form').on 'click', ->

    console.log '......'

    $('.modal-overlay').show()
    $('.modal-form').css('right', '-3000px')

    $('.modal-overlay').unbind()
    $('.modal-overlay').on 'click', ->
      hide_form()

    $('.modal-overlay').animate({'opacity' : '0.7'}, 200, ->
      $('.modal-form').show()
      $('.modal-form').animate({'right': '50%'}, 200)
    )

  $('#hide-thank-you').on 'click', ->
    hide_thank_you()



  $('.send-form').on 'click', ->

    username = $(@).parent().find('input[name=username]')
    phone = $(@).parent().find('input[name=phone]')

    shake_fields = []

    if username.val() < 2
      shake_fields.push username

    if phone.val() < 10
      shake_fields.push phone

    if shake_fields.length > 0
      shake_field(field) for field in shake_fields
      return false

    $.post(
      '/orders.json',
      {
        'order[username]': username.val(),
        'order[phone]': phone.val()
      }
    )


    if $(@).attr('inline_form') == 'true'
      show_thank_you_with_overlay()
      console.log '123123'
    else
      $('.modal-form').animate({'top': '-1000px'}, 300, ->
        show_thank_you()
        $('.modal-form').hide()
        $('.modal-form').css('top', '50%')
      )

    reach_goal 'new_order'




window.hide_form = ->
  $('.modal-form').animate {'top': '-2000px'}, 500, ->
    $('.modal-form').hide()
    $('.modal-overlay').animate {'opacity': '0.1'}, 300, ->
      $('.modal-overlay').hide()
      $('.modal-form').css('top', '50%')



window.show_thank_you_with_overlay = ->

  $('.modal-overlay').show()

  $('.modal-overlay').unbind()
  $('.modal-overlay').on 'click', ->
    hide_thank_you()

  $('.modal-thank-you').css('right', '-500px')
  $('.modal-thank-you').show()


  $('.modal-overlay').animate({'opacity' : '0.7'}, 200, ->
    $('.modal-thank-you').animate({'right': '50%'}, 500, ->
      $('input').val('')
    )
  )


window.show_thank_you = ->

  $('.modal-overlay').unbind()
  $('.modal-overlay').on 'click', ->
    hide_thank_you()

  $('.modal-thank-you').css('right', '-500px')
  $('.modal-thank-you').show()
  $('.modal-thank-you').animate({'right': '50%'}, 500, ->
    $('input').val('')
  )

window.hide_thank_you = ->
  $('.modal-thank-you').animate {'top': '-2000px'}, 500, ->
    $('.modal-thank-you').hide()
    $('.modal-overlay').animate {'opacity': '0'}, 300, ->
      $('.modal-thank-you').css('top', '50%')
      $('.modal-overlay').hide()


window.shake_field = (field) ->
  shake(field, i) for i in [1..10]


window.shake = (field, i) ->

  if i%2
    field.animate({height: '-=10'}, 100)
  else
    field.animate({height: '+=10'}, 100)

window.reach_goal = (goal) ->
#  yaCounter24590714.reachGoal(goal)



