class Map
  API_KEY = "947e1d95ed0144569fb1066e9e900d8b"

  constructor: (@lat, @long, @zoom) ->
    @map = L.map('map').setView([@lat, @long], @zoom)

    L.tileLayer("http://{s}.tile.cloudmade.com/#{API_KEY}/997/256/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
    }).addTo(@map);

  popup: (lat, long, text) ->
    L.marker([lat, long]).addTo(@map).bindPopup(text).openPopup();