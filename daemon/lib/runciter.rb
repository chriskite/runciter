# Your starting point for daemon specific classes. This directory is
# already included in your load path, so no need to specify it.

module Runciter
  class Watchdog

    def initialize
      begin
        @mail_config = DaemonKit::Config.load('mail').to_h(true)
        if @mail_config.has_key?(:via)
          @mail_config[:via] = @mail_config[:via].to_sym
        end
        if @mail_config.has_key?(:via_options)
          if @mail_config[:via_options].has_key?(:login)
            @mail_config[:via_options][:login] = @mail_config[:via_options][:login].to_sym
          end
        end
      rescue
        DaemonKit.logger.error "You must configure daemon/config/mail.yml. Try starting from mail.yml.example"
        exit
      end
    end

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
            run.state = 'gone away'
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
        begin
          DaemonKit.logger.debug "emailing #{alert['emails'].join(',')} #{alert['msg']}"
          opts = @mail_config.merge(
            to: alert['emails'],
            subject: 'Runciter Alert',
            body: alert['msg'],
          )
          puts opts.inspect
          Pony.mail(opts)
        rescue
          DaemonKit.logger.error $!.to_s
        end
      end
    end

    def queue_alert(emails, type, obj)
      if !!emails && emails.is_a?(Array) && !emails.empty?
        Alert.push(emails, obj.to_s)
        DaemonKit.logger.debug "enqueue to #{emails.join(',')} #{obj}"
      else
        DaemonKit.logger.warn "no emails for alert"
      end
    end

  end
end
