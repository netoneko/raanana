class FoursquareDatasource extends Datasource
  CLIENT_ID = "TY1ARBVSEIZHZVAZZRHIEQNDJS0FMWIBN0UBL1SBNJQB5Z1Z"
  CLIENT_SECRET = "BHMPRXUFOU2K2GI4BO5URAQW350L5LJ5P2A2Q3WQBMRNGOHL"
  LIMIT = 16

  constructor: (@map, @lat, @long) ->
    super @map, '#venues', {
      url: => "https://api.foursquare.com/v2/venues/explore?ll=#{@lat},#{@long}&radius=2000&limit=#{LIMIT}
                &client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&callback=?"
      extractData: (data) -> data.response.groups[0].items
      processData: (item) =>
        venue = item.venue

        @map.popup venue.location.lat, venue.location.lng, "<a href=#{venue.canonicalUrl} target=_blank><img src=#{venue.categories[0].icon}> #{venue.name}</a>"

        tip = item.tips[0].text if item.tips? && item.tips.length > 0
        Template.venue {venue: venue, icon: venue.categories[0].icon, tip: tip}
    }