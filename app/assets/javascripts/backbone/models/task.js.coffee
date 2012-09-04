class Runciter.Models.Task extends Backbone.Model
  paramRoot: 'task'

  defaults:
    name: null

class Runciter.Collections.TasksCollection extends Backbone.Collection
  model: Runciter.Models.Task
  url: '/tasks'
