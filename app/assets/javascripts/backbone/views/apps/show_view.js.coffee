Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.ShowView extends Backbone.View
  template: JST["backbone/templates/apps/show"]

  render: ->
    @model.fetch_tasks (tasks)=>
      @model.set('tasks', tasks)
      @$el.html(@template({app: @model}))
      tasks = @model.get('tasks')
      tasks.each (task)=>
        task.view = new Runciter.Views.Tasks.ShowView({el: $('#task-' + task.get('_id')), model: task})

      update = =>
        tasks.each (task)=>
          task.view.render ->
            $('#apps').masonry({itemSelector: '.app'})

      update()

      window.router.kioskView.on('kioskToggle', update)

      setInterval ->
        update()
      , 5000

    return this
