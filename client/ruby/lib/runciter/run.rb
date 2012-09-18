require 'thread'

module Runciter
  class Run
    attr_reader :id

    def initialize(app, task, opts = {})
      @app, @task = app, task
      @opts = opts
      @heartbeat_interval = @opts[:heartbeat_interval] || 60

      register!
      run_heartbeat_thread!
    end

    def step!(num = 1)
      @app.api[:runs].incr_step(@id, num)
    end

    def finish!
      @app.api[:runs].finish(@id)
      @heart.terminate
    end

    def die!(e)
      @app.api[:runs].die(@id, [e.message, e.backtrace].join("\n"))
      @heart.terminate
    end

    protected

    def register!
      doc = @app.api[:runs].start(@task.id, @opts)
      @id = doc['_id']
    end

    def run_heartbeat_thread!
      @heart = Thread.new do
        @app.api[:runs].heartbeat(@id)
        sleep @heartbeat_interval
      end
    end

  end
end
