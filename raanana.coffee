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


  lookupLocationFromSearchbox = -> lookupLocation $('.search-query').attr('value'), updateDatasources


  Template.index.events 'keypress': (event) ->
    if event.charCode is 13
      lookupLocationFromSearchbox()

  Meteor.startup ->
    lookupLocationFromSearchbox()

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    console.log "Server startup"