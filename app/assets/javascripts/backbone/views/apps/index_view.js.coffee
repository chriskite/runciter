Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.IndexView extends Backbone.View
  template: JST["backbone/templates/apps/index"]

  initialize: ->
    _.bindAll(this, 'render')
    @model.bind('change', @render)
    @model.bind('reset', @render)

  render: ->
    $(@el).html(@template(apps: @model))
    return this
