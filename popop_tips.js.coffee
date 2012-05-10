###
    README:
     this library requires : jQuery.cookie  .
     currently, only support single tips in a page
###
close_text = " - OK, I know"
open_text = " + Tips available"

is_open_key_prefix_in_cookie = "tips_open_"

get_cookie_key = (tip_element) ->
  encoded_content = ""
  try
    encoded_content = tip_element.text().trim().substr(0, 10).trim().toLowerCase().replace(/[\*\^\'\!\,]/g, '').split(' ').join('_')
  catch error
    encoded_content = "error"
  return is_open_key_prefix_in_cookie + encoded_content

set_toggle_text = (toggle_text_element, cookie_key) ->
  tip_is_open = $.cookie(cookie_key) == null || $.cookie(cookie_key) == "true"
  toggle_text_element.text(if tip_is_open then close_text else open_text)

@popop_tip = (tip_element) ->
  return if $(tip_element).parent().attr('class') == 'popop_tips'
  cookie_key = get_cookie_key($(tip_element))
  $(tip_element).wrap "<div class='popop_tips'/>"
  $(tip_element).before "<p class='toggle_icon'><a href='#' class='toggle_link'></a></p>"
  $(tip_element).css 'clear','both'

  toggle_text_element = $(tip_element).parent().find(".toggle_icon a")

  # init the tip and set the toggle_text
  set_toggle_text(toggle_text_element , cookie_key)
  tip_is_open = $.cookie(cookie_key) == null || $.cookie(cookie_key) == "true"
  $(tip_element).css('display', if tip_is_open then 'block' else 'none' )

  tip_element_tip = tip_element
  # set the toggle_function
  $(tip_element_tip).parent().find(".toggle_icon a").click ->
    $(tip_element_tip).toggle('fast', ->
      $.cookie(cookie_key, $(tip_element_tip).css('display') != 'none' )
      set_toggle_text(toggle_text_element , cookie_key)
    )

$(->
  $(".tip").each( ->
    window.popop_tip(this)
  )
)


