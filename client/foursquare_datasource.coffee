class FoursquareDatasource
  CLIENT_ID = "TY1ARBVSEIZHZVAZZRHIEQNDJS0FMWIBN0UBL1SBNJQB5Z1Z"
  CLIENT_SECRET = "BHMPRXUFOU2K2GI4BO5URAQW350L5LJ5P2A2Q3WQBMRNGOHL"

  constructor: (@map, @limit) ->
    @url = "https://api.foursquare.com/v2/venues/explore?ll=#{@map.lat},#{@map.long}&radius=2000&limit=#{limit}&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&callback=?"

  getData: ->
    $.getJSON @url, {}, (data) =>
      venues = $('#venues')
      _.each data.response.groups[0].items, (item, index) =>
        venue = item.venue

        tip = item.tips[0].text if item.tips? && item.tips.length > 0
        venues.append Template.venue {venue: venue, icon: venue.categories[0].icon, tip: tip}

        @map.popup venue.location.lat, venue.location.lng, "<a href=#{venue.canonicalUrl} target=_blank><img src=#{venue.categories[0].icon}> #{venue.name}</a>"
