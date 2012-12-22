class Datasource
  constructor: (@map, @domElement, @callbacks)->
    #

  render: (results) ->
    node = $(@domElement).empty()
    _.each results, (result) =>
      node.append result

  processData: ->
    $.getJSON @callbacks.url(@map), {}, (data) =>
      this.render _.map(@callbacks.extractData(data), @callbacks.processData)
