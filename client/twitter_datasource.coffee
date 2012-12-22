class TwitterDatasource extends Datasource
  constructor: (@map)->
    super @map, '#tweets', {
      url:
        (map) -> "http://search.twitter.com/search.json?geocode=#{map.lat},#{map.long},2km&result_type=recent&include_entities=true&callback=?"
      extractData: (data) -> data.results
      processData: (tweet) ->
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

        Template.tweet {tweet: tweet, text: text, timestamp: timestamp}
    }