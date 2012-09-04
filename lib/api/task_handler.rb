module Api
  class TaskHandler
    extend Jimson::Handler

    def create(name, app_id)
      Task.find_or_create_by(name: name, app_id: app_id)
    end

    def delete(id)
      Task.destroy(_id: id)
    end

  end
end
