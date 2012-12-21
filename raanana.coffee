if Meteor.isClient
  Template.hello.greeting = -> "Welcome to raanana."

  Template.hello.events 'click input' : ->
      # template data, if any, is available in 'this'
      if (typeof console not 'undefined')
        console.log("You pressed the button")

  Meteor.startup ->
    map = new Map(32.184802, 34.871672, 14)

    twitter = new TwitterDatasource(map)
    twitter.getData()

    foursquare = new FoursquareDatasource(map, 16)
    foursquare.getData()

    instagram = new InstagramDatasource(map)
    instagram.getData()

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    console.log "Server startup"