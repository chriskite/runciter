class Alert
  include Mongoid::Document
  include Mongoid::Timestamps
  field :msg, type: String
  field :emails, type: Array

  def self.push(emails, msg)
    alert = self.new
    alert.msg = msg
    alert.emails = emails
    alert.save!
  end

  def self.pop
    app = self.first
    app.remove if !!app
    app
  end

end
