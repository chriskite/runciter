class Run
  include Mongoid::Document
  include Mongoid::Timestamps
  field :steps, type: Integer
  field :steps_done, type: Integer
  field :heartbeat_interval, type: Integer
  field :last_heartbeat_at, type: Time
  field :started_at, type: Time
  field :finished_at, type: Time
  field :state, type: String
  field :message, type: String
  field :flatlined, type: Boolean

  belongs_to :task

  def get_pulse
    if !!last_heartbeat_at && !!heartbeat_interval
      overdue_by = (Time.now - last_heartbeat_at).to_f / heartbeat_interval.to_f
      if overdue_by < 1.0
        return 'ok'
      elsif overdue_by < 3.0
        return 'slow'
      end
      return 'flatline'
    else
      return 'n/a'
    end
  end

  def to_s
    self.inspect
  end

end
