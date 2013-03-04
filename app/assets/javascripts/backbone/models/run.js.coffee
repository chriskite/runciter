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
    return false if @get('state') == 'died' || @get('state') == 'gone away'
    return true

class Runciter.Models.TaskRun extends Runciter.Models.Run
  namespace: 'tasks'
  methods:
    read: ['latest_run_for', 'id'],

class Runciter.Collections.RunsCollection extends Backbone.Collection
  model: Runciter.Models.Run

class Runciter.Collections.TaskRunsCollection extends Backbone.Collection
  model: Runciter.Models.Run
  url: '/api'
  rpc: new Backbone.Rpc {namespaceDelimiter: '.'}
  namespace: 'tasks'
  methods:
    read: ['recent_runs_for', 'id']
  status: =>
    result = 'good'
    @each (run) ->
      result = 'warn' if !run.isOK()
    result = 'bad' if !@at(0).isOK()
    return result
