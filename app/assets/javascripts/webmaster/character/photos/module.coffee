#= require humanize

# ---------------------------------------------------------
# PHOTOS
# ---------------------------------------------------------

@Character.Webmaster.Photos = {}

#
# Marionette.js Layout Documentation
# https://github.com/marionettejs/backbone.marionette/blob/master/docs/marionette.itemview.md
# character/generic/details.coffee
@Character.Webmaster.Photos.DetailsLayout = Character.Generic.DetailsLayout.extend
  beforeContentRequest: ->
    if not @model
      @headerView.ui.actionSave.html('Upload').attr('title', 'Start uploading files')

  _addFile: (data) ->
    file = data.files[0]
    name = file.name
    size = Humanize.fileSize(file.size)

    $newFile  = $("<div class='webmaster-photo'></div")
    $canvasEl = $("<canvas>")
    $titleEl  = $("<div class='string'><input type=text placeholder='Title' /></div>")
    $metaEl   = $("<div class='meta'>#{name}<span class='size'>#{size}</span></div>")

    $newFile.append($canvasEl)
    $newFile.append($titleEl)
    $newFile.append($metaEl)
    $newFile.prependTo('#webmaster_photos')

    # image preview
    reader  = new FileReader()
    canvas  = $canvasEl[0]
    canvas.width  = 58
    canvas.height = 58
    context = canvas.getContext('2d')
    reader.onload = (e) ->
      $img = $('<img>', { src: e.target.result, style: 'visibility: hidden; position: absolute;' })
      $newFile.append($img)

      width = $img.width() ; height = $img.height() ; x = 0 ; y = 0
      if width  > height # landscape
        x = (width - height) / 2 ; width = height
      if height > width # portrait
        y = (height - width) / 2 ; height = width
      else # square
        ;

      $img.load -> context.drawImage(@, x, y, width, height, 0, 0, 58, 58)

    reader.readAsDataURL(file)

    @headerView.ui.actionSave.on 'click', (e) =>
      data.formData = { 'f': 'title,updated_ago,character_thumb_image' }
      titleAttrName = @ui.uploadInput.attr('name').replace('image', 'title')
      data.formData[titleAttrName] = $titleEl.children('input:eq(0)').val()

      data.submit().done (data, result) =>
        $newFile.remove()
        @collection.add(data)
        @collection.sort()

  _fileUploadFinished: ->
    @headerView.ui.actionSave.off 'click'
    setTimeout ( =>
      @headerView.ui.actionSave.removeClass?('disabled')
      @headerView.ui.actionSave.html?('Upload')
    ), 500

  afterRenderContent: ->
    if not @model
      @ui.uploadInput = $('#webmaster_photos_upload')
      @ui.uploadInput.parent().after("<div id='webmaster_photos' class='webmaster-photos'></div>")

      # https://github.com/blueimp/jQuery-File-Upload/wiki/Options
      @ui.uploadInput.fileupload
        url:             @ui.uploadInput.attr('data-url')
        paramName:       @ui.uploadInput.attr('name')
        dataType:        'json'
        autoUpload:      false
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
        dropZone:        false
        pasteZone:       false
        add: (e, data) => @_addFile(data)
        done: => @_fileUploadFinished()

  beforeSave: ->
    @headerView.ui.actionSave.addClass('disabled')
    @headerView.ui.actionSave.html 'Uploading...'

  beforeOnClose: ->
    # TODO: gently clear the memory
    #if @ui.uploadInput
    #  @ui.uploadInput.fileupload('destroy')

chr.photosModule = (name='Photo', opts={}) ->
  options =
    implementation: Character.Webmaster.Photos
    menuTitle:      'Photos'
    listTitle:      'Photos'
    menuIcon:       'picture-o'
    modelName:      'Webmaster-Photo'
    objectName:     'Photos'
    listItem:
      titleField:   'title'
      metaField:    'updated_ago'
      thumbField:   'character_thumb_image'
    listScopes:
      default:
        orderBy:    'date:desc'
  options = _.extend(options, opts)

  chr.genericModule name, options