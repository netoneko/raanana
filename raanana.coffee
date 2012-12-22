if Meteor.isClient
#  Template.hello.greeting = -> "Welcome to raanana."
#
#  Template.hello.events 'click input' : ->
#      # template data, if any, is available in 'this'
#      if (typeof console not 'undefined')
#        console.log("You pressed the button")

  lookupLocation = (location, renderCallback) ->
    if location is "Raanana"
      renderCallback("32.184802", "34.871672")
    else
      url = "http://nominatim.openstreetmap.org/search.php?q=#{location}&format=json"
      $.getJSON url, {}, (data) =>
        if (city = data[0])?
          renderCallback(city.lat, city.lon)


  updateDatasources = (lat, long) ->
    map = new Map(lat, long, 14)
    _.each [TwitterDatasource, InstagramDatasource, FoursquareDatasource], (datasource) ->
      new datasource(map).processData()


  lookupLocationFromSearchbox = ->
    document.location.hash = location = $('.search-query').attr('value')
    lookupLocation location, updateDatasources


  Template.index.events {
    'keypress .search-query': (event) ->
      if event.keyCode is 13
        lookupLocationFromSearchbox()
    }

  Meteor.startup ->
    $('.search-query').attr('value', document.location.hash.replace('#', '') || "Raanana")
    lookupLocationFromSearchbox()

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    console.log "Server startup"