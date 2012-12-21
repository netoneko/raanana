if Meteor.isClient
  Template.hello.greeting = -> "Welcome to raanana."

  Template.hello.events 'click input' : ->
      # template data, if any, is available in 'this'
      if (typeof console not 'undefined')
        console.log("You pressed the button")

  Meteor.startup ->
    map = new Map(32.184802, 34.871672, 13)
    datasource = new TwitterDatasource(map)
    datasource.getData()

    Template.index.radius = -> datasource.radius

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    console.log "Server startup"