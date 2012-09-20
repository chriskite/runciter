module Api
  class AppHandler
    extend Jimson::Handler

    def list
      App.all
    end

    def get(id)
      find_app(i)
    end

    def create(name)
      App.find_or_create_by(name: name)
    end

    def tasks_for(id)
      app = find_app(id)
      app.tasks
    end

    def cron(id, cron)
      app = find_app(id)
      app.cron = cron
      app.save!
    end

    protected

    def find_app(id)
      app = App.find(id)
      raise "No such app" if app.nil?
      app
    end

  end
end
