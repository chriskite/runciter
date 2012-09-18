class Runciter.Models.Task extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'tasks'
  methods:
    read: ['get', 'id']

  defaults:
    name: null

  fetch_run: (callback)->
    run = new Runciter.Models.TaskRun
    run.fetch
      id: @get('_id')
      success: (run)=>
        callback(run)

class Runciter.Collections.TasksCollection extends Backbone.Collection
  model: Runciter.Models.Task

class Runciter.Collections.AppTasksCollection extends Backbone.Collection
  model: Runciter.Models.Task
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['tasks_for', 'id']
