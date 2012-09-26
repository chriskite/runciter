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
      task = Task.new(self, name, opts)
      task.run!(&block)
    end

    protected

    def register!
      doc = @api[:apps].create(@name)
      @id = doc['_id']

      if cron_str = @opts.delete(:cron)
        @api[:apps].cron(@id, cron_str)
      end

      if alert_emails = @opts.delete(:alert)
        @api[:apps].alert_emails(@id, [alert_emails].flatten)
      end
      rescue
        warn $!
    end

  end
end
