class Runciter.Models.Run extends Backbone.Model
  paramRoot: 'run'

  defaults:
    steps: null
    steps_done: null
    heartbeat_interval: null
    last_heartbeat_at: null
    started_at: null
    finished_at: null
    state: null
    message: null

class Runciter.Collections.RunsCollection extends Backbone.Collection
  model: Runciter.Models.Run
  url: '/runs'
