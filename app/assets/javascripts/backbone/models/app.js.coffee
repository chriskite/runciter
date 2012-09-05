class Runciter.Models.App extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['get']

  defaults:
    name: null
    tasks: new Backbone.Collection

  initialize: ->
    @fetch_tasks()

  fetch_tasks: (actions)->
    collection = new Runciter.Collections.AppTasksCollection
    collection.fetch
      id: @get('_id')
      success: (tasks)=>
        @set('tasks', tasks)

class Runciter.Collections.AppsCollection extends Backbone.Collection
  model: Runciter.Models.App
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['list']
