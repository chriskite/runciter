Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.IndexView extends Backbone.View
  tagName: 'div',
  id: 'apps',
  template: JST["backbone/templates/apps/index"]

  render: ->
    $(@el).html(@template(apps: @model))
    @model.each (app)=>
      appView = new Runciter.Views.Apps.ShowView({el: $('#app-' + app.get('_id')), model: app})
      appView.render()
    return this
