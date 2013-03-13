class Runciter.Models.Run extends Backbone.Model
  url: '/api'
  namespace: 'runs'
  method: 'get'
  params: =>
    [ @get('id') ]

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
  method: 'latest_run_for'
  params: =>
    [ @get('id') ]

class Runciter.Collections.RunsCollection extends Backbone.Collection
  model: Runciter.Models.Run

class Runciter.Collections.TaskRunsCollection extends Backbone.Collection
  model: Runciter.Models.Run
  url: '/api'
  namespace: 'tasks'
  method: 'recent_runs_for'
  params: =>
    [ @.id ]
  status: =>
    result = 'good'
    @each (run) ->
      result = 'warn' if !run.isOK()
    result = 'bad' if !@at(0).isOK()
    return result
