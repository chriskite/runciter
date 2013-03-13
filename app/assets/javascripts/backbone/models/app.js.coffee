class Runciter.Models.App extends Backbone.Model
  url: '/api'
  namespace: 'apps'
  method: 'get'
  params: =>
    [ @get('id') ]

  defaults:
    name: null
    tasks: new Backbone.Collection

  fetch_tasks: (callback)->
    collection = new Runciter.Collections.AppTasksCollection
    collection.id = @get('_id')
    collection.fetch
      success: (tasks)=>
        callback(tasks)

class Runciter.Collections.AppsCollection extends Backbone.Collection
  model: Runciter.Models.App
  url: '/api'
  namespace: 'apps'
  method: 'list'
