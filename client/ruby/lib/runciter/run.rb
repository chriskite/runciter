module Runciter
  class Run
    attr_reader :id

    def initialize(app, task, opts = {})
      @app, @task = app, task
      @opts = opts

      register!
    end

    def step!(num = 1)
      @app.api[:runs].incr_step(@id, num)
    end

    def finish!
      @app.api[:runs].finish(@id)
    end

    def die!(e)
      @app.api[:runs].die(@id, [e.message, e.backtrace].join("\n"))
    end

    protected

    def register!
      doc = @app.api[:runs].start(@task.id, @opts)
      @id = doc['_id']
    end

  end
end
