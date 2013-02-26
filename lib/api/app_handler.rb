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
      app = App.find_or_create_by(name: name)
      app.started_at = Time.now
      app.save!
      app
    end

    def delete(id)
      app = find_app(id)
      app.destroy
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

    def alert_emails(id, emails)
      app = find_app(id)
      raise "Argument must be array of emails" if !emails.is_a?(Array)

      app.alert_emails = emails
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
