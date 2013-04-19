module Api
  class RunHandler
    extend Jimson::Handler

      def start(task_id, opts = {})
        raise "No task_id specified" if task_id.nil?
        task = Task.find(task_id)
        raise "No such task" if task.nil?

        Run.create!(
          task: task,
          started_at: Time.now,
          steps: opts['steps'],
          heartbeat_interval: opts['heartbeat_interval'],
          state: 'running'
        )
      end

      def incr_step(task_id, run_id, by = 1)
        run = find_run(task_id, run_id)

        run.inc(:steps_done, by)
      end

      def pulse(task_id, run_id)
        run = find_run(task_id, run_id)
        run.pulse
      end

      def heartbeat(task_id, run_id)
        run = find_run(run_id)

        run.last_heartbeat_at = Time.now

        run.state = 'running' if 'gone away' == run.state

        run.save!
      end

      def die(task_id, run_id, message = "Task died unexpectedly")
        run = find_run(task_id, run_id)

        run.state = 'died'
        run.message = message
        run.finished_at = Time.now

        Alert.push(run.task.app.alert_emails, run.to_s)

        run.save!
      end

      def finish(task_id, run_id)
        run = find_run(task_id, run_id)

        run.state = 'done'
        run.finished_at = Time.now

        run.save!
      end

      protected

      def find_run(task_id, run_id)
        task = Task.find(task_id)
        raise "No such task" if task.nil?
        run = task.runs.find(run_id)
        raise "No such run" if run.nil?
        run
      end

  end
end
