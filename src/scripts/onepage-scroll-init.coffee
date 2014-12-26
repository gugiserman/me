$(document).ready ->
  $('.container').onepage_scroll
    loop: false
    animationTime: 800
    beforeMove: -> $(window).trigger 'ggScrollStart', []
    afterMove: -> $(window).trigger 'ggScrollEnd', []
