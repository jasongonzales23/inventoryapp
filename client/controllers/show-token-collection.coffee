Template.showTokenCollections.collections = ->
  TokenCollections.find({ 'location': @_id}, {sort: {timestamp: -1}})
