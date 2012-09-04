module Runciter
  class App
    attr_reader :id,
                :api,
                :name,
                :heartbeat_interval,
                :endpoint

    def initialize(opts)
      name = opts[:name]
      endpoint = opts[:endpoint]
      heartbeat_interval = opts[:heartbeat_interval] || 60

      @api = Jimson::Client.new(endpoint)
      @api[:system].isAlive # test connection
    end

    def task(name, opts = {}, &block)
      Task.new(self, name, opts).run!(&block)
    end

    def name=(name)
      @name = name.to_s
    end

    def heartbeat_interval=(int)
      @heartbeat_interval = int.to_i
    end

    def endpoint=(url)
      @endpoint = URI(url)
    end

  end
end
