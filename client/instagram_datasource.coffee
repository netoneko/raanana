class InstagramDatasource
  CLIENT_ID = "9bbb984491c9466ea5ad3ef1e45ee6e3"

  constructor: (@map) ->
    @url = "https://api.instagram.com/v1/media/search?client_id=#{CLIENT_ID}&lat=32.184802&lng=34.871672&callback=?"

  getData: ->
    $.getJSON @url, {}, (data) =>
      photos = $('#instagram .photos')
      _.each data.data, (item, index) =>
        #comment = item.comments.data[0].text if item.comments.count > 0
        photos.append Template.photo {src: item.images.thumbnail.url, url: item.link}