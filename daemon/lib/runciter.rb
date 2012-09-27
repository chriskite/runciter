# Your starting point for daemon specific classes. This directory is
# already included in your load path, so no need to specify it.

module Runciter
  class Watchdog

    def run!
      loop do
        check_apps
        check_runs
        send_pending_alerts
        sleep 5
      end
    end

    protected

    def check_apps
      App.each do |app|
        if app.is_late
          # send alert if it's not already late, and set late = true
          queue_alert(app.alert_emails, :late, app) if !app.late
          app.late = true
        else
          app.late = false
        end
        app.save!
      end
    end

    def check_runs
      Run.where('state' => 'running').each do |run|
        begin
          if 'flatline' == run.get_pulse
            # send alert if we haven't already, and set flatlined = true
            queue_alert(run.task.app.alert_emails, :flatline, run) if !run.flatlined
            run.flatlined = true
          else
            run.flatlined = false
          end
          run.save!
        rescue
          DaemonKit.logger.warn $!
        end
      end
    end

    def send_pending_alerts
      while !!(alert = Alert.pop) do
        DaemonKit.logger.debug "emailing #{alert['emails'].join(',')} #{alert['msg']}"
        Pony.mail(
          to: alert['emails'],
          subject: 'Runciter Alert',
          body: alert['msg'],
          from: 'runciter@' + Socket.gethostname
        )
      end
    end

    def queue_alert(emails, type, obj)
      if !!emails && emails.is_a?(Array) && !emails.empty?
        Alert.push(emails, "#{type.to_s}\n#{obj.inspect}")
        DaemonKit.logger.debug "enqueue to #{emails.join(',')} #{type.to_s} #{obj.inspect}"
      else
        DaemonKit.logger.warn "no emails for alert"
      end
    end

  end
end
