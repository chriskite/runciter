Runciter.Views.Tasks ||= {}

class Runciter.Views.Tasks.ShowView extends Backbone.View
  template: JST["backbone/templates/tasks/show"]

  render: (callback)->
    @model.fetch_runs (runs)=>
      if(runs.length > 0)
        @model.set('runs', runs)
        $(@el).html(@template({task: @model}))
        $(@el).find('.recentRuns .running').animate {opacity: .25}
          , 5000
          , (-> $(this).animate({opacity: 1}, 5000))
        $(@el).find('.recentRun').tooltip(html: true, placement: 'bottom')
        callback(this) if callback
    return this
