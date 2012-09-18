Runciter.Views.Tasks ||= {}

class Runciter.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]

  render: ->
    console.log(@model)
    @model.fetch_run (run)=>
      @model.set('run', run)
      $(@el).html(@template({task: @model}))
    return this
