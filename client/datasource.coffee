class TwitterDatasource
  constructor: (@map)->
    @radius = "2km"
    @url = "http://search.twitter.com/search.json?geocode=#{@map.lat},#{@map.long},#{@radius}
     &result_type=mixed&include_entities=true&callback=?"

  getData: ->
    $.getJSON @url, {}, (data) =>
      tweets = $('#tweets')
      _.each data.results, (tweet) =>
        text = tweet.text

        time = new Date() - new Date(Date.parse(tweet.created_at))

        timestamp = if (t = Math.round(time / 1000 / 60 / 60, 1)) > 0
          timestamp =  "#{t}h"
        else
          timestamp = ">1h"


        if (entities = tweet.entities)?
          _.each entities.urls, (url) ->
            text = text.replace url.url, "<a href='#{url.expanded_url}' target=_blank>#{url.display_url}</a>"

          _.each entities.media, (media) ->
            text = text.replace media.url, "<a href='#{media.expanded_url}' target=_blank>#{media.display_url}</a>"
            # text += "<img src='#{media.media_url}'/><br/>"

        tweets.append Template.tweet {tweet: tweet, text: text, timestamp: timestamp}


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