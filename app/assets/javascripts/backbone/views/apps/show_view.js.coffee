Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.ShowView extends Backbone.View
  template: JST["backbone/templates/apps/show"]

  render: ->
    $(@el).html(@template())
    return this
