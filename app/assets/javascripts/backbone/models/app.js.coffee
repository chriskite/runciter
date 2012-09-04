class Runciter.Models.App extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['get']

  defaults:
    name: null

class Runciter.Collections.AppsCollection extends Backbone.Collection
  model: Runciter.Models.App
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'apps'
  methods:
    read: ['list']
