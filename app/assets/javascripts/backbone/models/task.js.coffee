class Runciter.Models.Task extends Backbone.Model
  url: '/api'
  namespace: 'tasks'
  method: 'get'
  params: =>
    [ @get('id') ]

  defaults:
    name: null

  fetch_run: (callback)->
    task_run = new Runciter.Models.TaskRun
    task_run.fetch
      id: @get('_id')
      success: (task_run)=>
        run = new Runciter.Models.Run(task_run.attributes)
        callback(run)

  fetch_runs: (callback)->
    collection = new Runciter.Collections.TaskRunsCollection
    collection.id = @get('_id')
    collection.fetch
      success: (runs)=>
        callback(runs)

  status: ->
    return @get('runs').status()

class Runciter.Collections.TasksCollection extends Backbone.Collection
  model: Runciter.Models.Task

class Runciter.Collections.AppTasksCollection extends Backbone.Collection
  model: Runciter.Models.Task
  url: '/api'
  namespace: 'apps'
  method: 'tasks_for'
  params: =>
    [ @.id ]
