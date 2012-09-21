module Runciter
  class Task
    attr_reader :name
    attr_reader :id

    def initialize(app, name, opts = {})
      @app = app
      @name = name
      @opts = opts

      register!
    end

    def run!(&block)
      run = Run.new(@app, self, @opts)

      begin
        block.call(run)
        run.finish! # finish! rescues its own exceptions
      rescue
        run.die!($!) # die! rescues its own exceptions
      end
    end

    protected

    def register!
      doc = @app.api[:tasks].create(@name, @app.id)
      @id = doc['_id']
      rescue
        warn $!
    end

  end
end
