class Runciter.Models.Task extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'tasks'
  methods:
    read: ['get', 'id']

  defaults:
    name: null

  fetch_run: (callback)->
    task_run = new Runciter.Models.TaskRun
    task_run.fetch
      id: @get('_id')
      success: (task_run)=>
        run = new Runciter.Models.Run(task_run.attributes)
        callback(run)

  isOK: ->
    return @get('run').isOK()

class Runciter.Collections.TasksCollection extends Backbone.Collection
  model: Runciter.Models.Task

class Runciter.Collections.AppTasksCollection extends Backbone.Collection
  model: Runciter.Models.Task
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['tasks_for', 'id']
  areOK: =>
    isOK = true
    @each (task) ->
      isOK = false if !task.isOK()
    return isOK