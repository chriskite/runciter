Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.ShowView extends Backbone.View
  template: JST["backbone/templates/apps/show"]

  render: ->
    @model.fetch_tasks (tasks)=>
      @model.set('tasks', tasks)
      @$el.html(@template({app: @model}))

      update = =>
        tasks = @model.get('tasks')
        tasks.each (task)=>
          taskView = new Runciter.Views.Tasks.ShowView({el: $('#task-' + task.get('_id')), model: task})
          taskView.render()
        if window.router.kioskView.active
          if tasks.areOK()
            @$el.removeClass('not-ok').addClass('ok')
          else
            @$el.removeClass('ok').addClass('not-ok')

      update()

      window.router.kioskView.on('kioskToggle', update)

      setInterval ->
        update()
      , 1000

    return this
