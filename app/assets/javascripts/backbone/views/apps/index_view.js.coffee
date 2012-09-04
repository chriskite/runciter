Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.IndexView extends Backbone.View
  template: JST["backbone/templates/apps/index"]

  render: ->
    $(@el).html(@template(apps: @collection))
    return this
