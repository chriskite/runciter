class Runciter.Models.Task extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'tasks'
  methods:
    read: ['get', 'id']

  defaults:
    name: null

class Runciter.Collections.TasksCollection extends Backbone.Collection
  model: Runciter.Models.Task

class Runciter.Collections.AppTasksCollection extends Backbone.Collection
  model: Runciter.Models.Task
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['tasks_for', 'id']
