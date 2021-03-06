module Api
  class TaskHandler
    extend Jimson::Handler

    def create(name, app_id)
      Task.find_or_create_by(name: name, app_id: app_id)
    end

    def delete(id)
      task = Task.find(id)
      raise "No such task" if task.nil?
      task.destroy
    end

    def latest_run_for(id)
      task = Task.find(id)
      raise "No such task" if task.nil?
      run = task.runs.last
      return nil if run.nil?
      run['pulse'] = run.get_pulse
      run
    end

    def recent_runs_for(id, num = 20)
      task = Task.find(id)
      raise "No such task" if task.nil?
      runs = task.runs.reverse
      runs.each { |run| run['pulse'] = run.get_pulse }
      runs
    end

  end
end
