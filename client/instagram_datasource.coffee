class InstagramDatasource extends Datasource
  CLIENT_ID = "9bbb984491c9466ea5ad3ef1e45ee6e3"

  constructor: (@map, @lat, @long) ->
    super @map, '#instagram .photos', {
      url: => "https://api.instagram.com/v1/media/search?client_id=#{CLIENT_ID}&lat=#{@lat}&lng=#{@long}&callback=?"
      extractData: (data) -> data.data
      processData: (item, index) -> Template.photo {src: item.images.thumbnail.url, url: item.link}
    }