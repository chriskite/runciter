class Runciter.Models.Run extends Backbone.Model
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'runs'
  methods:
    read: ['get', 'id']

  defaults:
    steps: null
    steps_done: null
    heartbeat_interval: null
    last_heartbeat_at: null
    started_at: null
    finished_at: null
    state: null
    message: null

  isOK: ->
    return false if @get('state') == 'died'
    return true

class Runciter.Models.TaskRun extends Runciter.Models.Run
  namespace: 'tasks'
  methods:
    read: ['latest_run_for', 'id'],

class Runciter.Collections.RunsCollection extends Backbone.Collection
  model: Runciter.Models.Run
