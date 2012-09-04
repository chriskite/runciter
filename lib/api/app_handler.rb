module Api
  class AppHandler
    extend Jimson::Handler

    def list
      App.all
    end

    def get(id)
      App.find(id)
    end

    def create(name)
      App.find_or_create_by(name: name)
    end

    def tasks_for(id)
      app = App.find(id)
      raise "No such app" if app.nil?
      app.tasks
    end

  end
end
