class App
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :cron, type: String
  field :alert_emails, type: Array
  field :late, type: Boolean

  has_many :tasks

  def is_late
    true    
  end

end
