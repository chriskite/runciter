module Runciter
  class Config
     attr_reader :app,
                 :heartbeat_interval,
                 :endpoint

    def app=(app)
      @app = app.to_s
    end

    def heartbeat_interval=(int)
      @heartbeat_interval = int.to_i
    end

    def endpoint=(url)
      @endpoint = URI(url)
    end

  end
end
