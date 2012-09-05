class Runciter.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "": "index"
    "show": "show"
  
  index: ->
    apps = new Runciter.Collections.AppsCollection
    view = new Runciter.Views.Apps.IndexView(el: $('#apps'), model: apps)
    apps.fetch()
    setInterval ->
      apps.fetch()
    , 10000

  show: ->
    @view = new Runciter.Views.Apps.ShowView()
    $("#apps").html(@view.render().el)

