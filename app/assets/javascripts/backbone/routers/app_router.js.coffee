class Runciter.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "": "index"
    "show": "show"
  
  index: ->
    apps = new Runciter.Collections.AppsCollection
    update = ->
      apps.fetch
        success: (apps, resp)->
          @view = new Runciter.Views.Apps.IndexView(collection: apps)
          $("#apps").html(@view.render().el)
    
    update()
    setInterval(update, 5000)

  show: ->
    @view = new Runciter.Views.Apps.ShowView()
    $("#apps").html(@view.render().el)

