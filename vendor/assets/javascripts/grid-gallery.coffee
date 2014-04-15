#= require _grid-gallery
#= require jquery

window.CBPGridGallery.prototype._initSlideshow = ->
  imagesLoaded @slideshow, =>
    @_resizeSlideshowItems()

window.CBPGridGallery.prototype._resizeSlideshowItems = ->
  minMargin    = 40
  windowWidth  = $(window).width()
  windowHeight = $(window).height()

  $(@slideshowItems).each (i, el) ->
    $el = $(el)

    # TODO: refactor with smart sizing based on image proportions and window proportions
    $img = $el.find('img:eq(0)')
    if $img.width() > $img.height()
      $img.css { 'max-width': windowWidth - minMargin * 2, height: 'auto' }
      # TODO: sometimes there is not enough space for height auto
    else if $img.width() < $img.height()
      $img.css { width: 'auto', 'max-height': windowHeight - minMargin * 2 }
      # TODO: probably same here
    else
      if windowWidth > windowHeight
        $img.css { width: 'auto', 'max-height': windowHeight - minMargin * 2 }
      else
        $img.css { 'max-width': windowWidth - minMargin * 2, height: 'auto' }

    $(el).css { 'margin-left': $(el).width() / -2, 'margin-top': $(el).height() / -2 }