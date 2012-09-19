module Api
  class RunHandler
    extend Jimson::Handler

      def start(task_id, opts = {})
        Run.create!(
          task_id: task_id,
          started_at: Time.now,
          steps: opts['steps'],
          heartbeat_interval: opts['heartbeat_interval'],
          state: 'running'
        )
      end

      def incr_step(run_id, by = 1)
        run = find_run(run_id)

        run.inc(:steps_done, by)
      end

      def pulse(run_id)
        run = find_run(run_id)
        run.pulse
      end

      def heartbeat(run_id)
        run = find_run(run_id)

        run.last_heartbeat_at = Time.now

        run.save!
      end

      def die(run_id, message = "Task died unexpectedly")
        run = find_run(run_id)

        run.state = 'died'
        run.message = message
        run.finished_at = Time.now

        run.save!
      end

      def finish(run_id)
        run = find_run(run_id)

        run.state = 'done'
        run.finished_at = Time.now

        run.save!
      end

      protected

      def find_run(run_id)
        run = Run.find(run_id)
        raise "No such run" if run.nil?
        run
      end

  end
end
