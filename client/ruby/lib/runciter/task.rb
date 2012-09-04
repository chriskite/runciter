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
      rescue
        run.die!($!)
      end

      run.finish!
    end

    protected

    def register!
      doc = @app.api[:tasks].create(@name, @app.id)
      @id = doc['_id']
    end

  end
end
