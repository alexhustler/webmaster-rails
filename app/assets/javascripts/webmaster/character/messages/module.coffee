# ---------------------------------------------------------
# MESSAGES
# ---------------------------------------------------------

chr.messagesModule = (name='Messages', opts={}) ->
  chr.genericModule name,
    menuIcon:       'envelope'
    menuTitle:      'Messages'
    listTitle:      'All'
    listSearch:     true
    listScopes:
      default:
        orderBy:    'created_at:desc'
      'Inbox':
        where:      'archived=false'
        orderBy:    'created_at:desc'
      'Archived':
        where:      'archived=true'
        orderBy:    'created_at:desc'
    listItem:
      titleField:   'chr_name_or_reply_to'
      metaField:    'created_ago'
    newItems:       false
    deletable:      true
    objectName:     'Message'
    modelName:      'Webmaster-Message'