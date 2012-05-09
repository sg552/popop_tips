close_link = "OK, I know"
$(->
  tip_div = $(".tip")
  tip_div.addClass("popop_tips")
  tip_div.prepend("<p class='toggle_icon'><a href='#'>" + close_link + "</a></p>")
)
