class TwitterDatasource
  constructor: (@map)->
    @radius = "5km"
    @url = "http://search.twitter.com/search.json?geocode=#{@map.lat},#{@map.long},#{@radius}
     &result_type=mixed&include_entities=true&callback=?"

  getData: ->
    $.getJSON @url, {}, (data) =>
      console.log data

      tweets = $('.tweets')
      _.each data.results, (tweet) =>
        text = tweet.text

        if (entities = tweet.entities)?
          _.each entities.urls, (url) ->
            text = text.replace url.url, "<a href='#{url.expanded_url}'>#{url.display_url}</a>"

          _.each entities.media, (media) ->
            text = text.replace media.url, "<a href='#{media.expanded_url}'>#{media.display_url}</a>"
            # text += "<img src='#{media.media_url}'/><br/>"


        preview = "<p>#{text}</p><small>#{tweet.from_user_name}   +
          (<a href='https://twitter.com/#{tweet.from_user}' target=_blank>@#{tweet.from_user}</a>) at
           <a href='https://twitter.com/#{tweet.from_user}/status/#{tweet.id_str}' target=_blank>#{tweet.created_at}</a></small>"

        tweets.append $("<blockquote><img src='#{tweet.profile_image_url}'/>#{preview}</blockquote>")

        if (geo = tweet.geo)? and geo.type is "Point"
          @map.popup geo.coordinates[0], geo.coordinates[1], preview