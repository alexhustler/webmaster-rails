# ---------------------------------------------------------
# PHOTOS
# ---------------------------------------------------------

chr.photosModule = (name='Photo', opts={}) ->
  options =
    menuTitle:      'Photos'
    listTitle:      'Photos'
    menuIcon:       'picture-o'
    modelName:      'Webmaster-Photo'
    listReorder:     true
    listItem:
      titleField:   'title'
      metaField:    'updated_ago'
      thumbField:   'character_thumb_image'

  options = _.extend(options, opts)

  chr.genericModule name, options