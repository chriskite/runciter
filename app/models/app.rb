class App
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :cron, type: String
  field :alert_emails, type: Array
  field :late, type: Boolean
  field :started_at, type: Time

  has_many :tasks

  def is_late
    if !!cron
      cp = CronParser.new(cron)
      return cp.last > (updated_at + 30) # 30 second leeway
    else
      return false # can't be late since no cron
    end
  end

end
