require 'thread'

module Runciter
  class Run
    attr_reader :id

    def initialize(app, task, opts = {})
      @app, @task = app, task
      @opts = opts
      @opts[:heartbeat_interval] ||= 30

      register!
      run_heartbeat_thread!
    end

    def step!(num = 1)
      @app.api[:runs].incr_step(@task.id, @id, num)
      rescue
        warn $!
    end

    def finish!
      @app.api[:runs].finish(@task.id, @id)
      @heart.terminate
      rescue
        warn $!
    end

    def die!(e)
      @app.api[:runs].die(@task.id, @id, [e.message, e.backtrace.join("\n")].join("\n"))
      @heart.terminate
      rescue
        warn $!
    end

    protected

    def register!
      doc = @app.api[:runs].start(@task.id, @opts)
      @id = doc['_id']
      rescue
        warn $!
    end

    def run_heartbeat_thread!
      @heart = Thread.new do
        loop do
          @app.api[:runs].heartbeat(@task.id, @id)
          sleep @opts[:heartbeat_interval]
        end
      end
      rescue
        warn $!
    end

  end
end
