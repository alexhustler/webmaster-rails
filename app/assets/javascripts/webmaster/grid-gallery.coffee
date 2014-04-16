#= require _grid-gallery
#= require spin
#= require jquery
#= require underscore

window.CBPGridGallery.prototype._addPhotos = (gridElements, slideshowElements) ->
  $(@grid).append(gridElements)
  $(@slideshow).append(slideshowElements)

  # update counters and lists
  @gridItems      = [].slice.call( this.grid.querySelectorAll( 'li:not(.grid-sizer)' ) )
  @itemsCount     = this.gridItems.length
  @slideshow      = this.el.querySelector( 'section.slideshow > ul' )
  @slideshowItems = [].slice.call( this.slideshow.children )

  # reload masonry
  @msnry.reloadItems()

  imgLoad = imagesLoaded(@grid)
  imgLoad.on 'progress', => @msnry.layout()

  imagesLoaded @slideshow, => @_resizeSlideshowItems()

window.CBPGridGallery.prototype._initInfiniteScroll = ->
  spinOpts =
    lines: 7              # The number of lines to draw
    length: 0             # The length of each line
    width: 12             # The line thickness
    radius: 15            # The radius of the inner circle
    corners: 1            # Corner roundness (0..1)
    rotate: 0             # The rotation offset
    direction: 1          # 1: clockwise, -1: counterclockwise
    color: '#3a4246'      # #rgb or #rrggbb or array of colors
    speed: 1              # Rounds per second
    trail: 20             # Afterglow percentage
    shadow: false         # Whether to render a shadow
    hwaccel: false        # Whether to use hardware acceleration
    className: 'spinner'  # The CSS class to assign to the spinner
    zIndex: 2e9           # The z-index (defaults to 2000000000)
    top: 'auto'           # Top position relative to parent in px
    left: '50%'           # Left position relative to parent in px

  spinTarget  = document.getElementById('grid_gallery_spin')
  @$spinTarget = $(spinTarget)
  @spinner    = new Spinner(spinOpts).spin(spinTarget)

  @lastPageReached = false
  @nextPageNumber  = 2

  loadMorePhotos = =>
    gridBottom    = $(@grid).outerHeight() + $(@grid).position().top
    nearToBottom  = 200
    bottomReached = $(window).scrollTop() + $(window).height() > gridBottom - nearToBottom

    if bottomReached and not @lastPageReached
      @$spinTarget.css({ visibility: 'visible' })
      $.ajax
        url: "#{ window.location.pathname }/#{ @nextPageNumber }"
        success: (response) =>
          @nextPageNumber += 1
          @$spinTarget.css({ visibility: 'hidden' })
          gridElements      = $(response).find('ul.grid li').not('.grid-sizer')
          slideshowElements = $(response).find('.slideshow ul li')

          if gridElements.length == 0
            @lastPageReached = true
          else
            @_addPhotos(gridElements, slideshowElements)

  $(window).scroll _.throttle(loadMorePhotos, 500)


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