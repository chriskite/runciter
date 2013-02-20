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
    return false if cron.nil? # can't be late since no cron
    expectation = CronParser.new(cron)
    expectation.last > (updated_at + 30) # 30 second leeway
  end

  def to_s
    self.inspect
  end

end
