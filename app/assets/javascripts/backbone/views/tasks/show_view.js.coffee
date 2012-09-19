Runciter.Views.Tasks ||= {}

class Runciter.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]

  render: ->
    @model.fetch_run (run)=>
      if(run.get('_id'))
        @model.set('run', run)
        $(@el).html(@template({task: @model}))
    return this
