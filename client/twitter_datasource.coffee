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
