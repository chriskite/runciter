class Runciter.Models.App extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['get', 'id']

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
        tasks.bind 'change', =>
          @set('tasks', tasks)
          @change()

class Runciter.Collections.AppsCollection extends Backbone.Collection
  model: Runciter.Models.App
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['list']
