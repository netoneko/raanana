class InstagramDatasource extends Datasource
  CLIENT_ID = "9bbb984491c9466ea5ad3ef1e45ee6e3"

  constructor: (@map) ->
    super @map, '#instagram .photos', {
      url: (map) -> "https://api.instagram.com/v1/media/search?client_id=#{CLIENT_ID}&lat=#{map.lat}&lng=#{map.long}&callback=?"
      extractData: (data) -> data.data
      processData: (item, index) -> Template.photo {src: item.images.thumbnail.url, url: item.link}
    }