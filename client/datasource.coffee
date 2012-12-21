class TwitterDatasource
  constructor: (@map)->
    @radius = "2km"
    @url = "http://search.twitter.com/search.json?geocode=#{@map.lat},#{@map.long},#{@radius}
     &result_type=mixed&include_entities=true&callback=?"

  getData: ->
    $.getJSON @url, {}, (data) =>
      console.log data

      tweets = $('#tweets')
      _.each data.results, (tweet) =>
        text = tweet.text

        if (entities = tweet.entities)?
          _.each entities.urls, (url) ->
            text = text.replace url.url, "<a href='#{url.expanded_url}' target=_blank>#{url.display_url}</a>"

          _.each entities.media, (media) ->
            text = text.replace media.url, "<a href='#{media.expanded_url}' target=_blank>#{media.display_url}</a>"
            # text += "<img src='#{media.media_url}'/><br/>"

        tweets.append $(Template.tweet {tweet: tweet, text: text})


class FoursquareDatasource
  CLIENT_ID = "TY1ARBVSEIZHZVAZZRHIEQNDJS0FMWIBN0UBL1SBNJQB5Z1Z"
  CLIENT_SECRET = "BHMPRXUFOU2K2GI4BO5URAQW350L5LJ5P2A2Q3WQBMRNGOHL"

  constructor: (@map, @limit) ->
    @url = "https://api.foursquare.com/v2/venues/explore?ll=#{@map.lat},#{@map.long}&radius=2000&limit=#{limit}&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"

  getData: ->
    $.getJSON @url, {}, (data) =>
      console.log data

      venues = $('#venues')
      _.each data.response.groups[0].items, (item) =>
        console.log item

        venue = item.venue
        tips = item.tips

        venues.append $(Template.venue {venue: venue, icon: venue.categories[0].icon})

        @map.popup venue.location.lat, venue.location.lng, "<a href=#{venue.canonicalUrl} target=_blank><img src=#{venue.categories[0].icon}> #{venue.name}</a>"

