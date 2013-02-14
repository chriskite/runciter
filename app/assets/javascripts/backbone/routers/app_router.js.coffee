class Runciter.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "": "index"
    "show": "show"
  
  index: ->
    apps = new Runciter.Collections.AppsCollection
    kioskMode = new Runciter.Views.Apps.KioskView
    view = new Runciter.Views.Apps.IndexView(el: $('#apps'), model: apps)
    apps.fetch
      success: ->
        view.render()

  show: ->
    @view = new Runciter.Views.Apps.ShowView()
    $("#apps").html(@view.render().el)

