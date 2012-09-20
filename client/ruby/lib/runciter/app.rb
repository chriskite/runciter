module Runciter
  class App
    attr_reader :id,
                :api

    def initialize(name, endpoint, opts = {})
      @name = name
      @endpoint = URI(endpoint)
      @opts = opts

      @api = Jimson::Client.new(endpoint)

      register!
    end

    def task(name, opts = {}, &block)
      Task.new(self, name, opts).run!(&block)
    end

    protected

    def register!
      doc = @api[:apps].create(@name)
      @id = doc['_id']
      if cron_str = @opts.delete(:cron)
        @api[:apps].cron(@id, cron_str)
      end
    end

  end
end
