class App
  include Mongoid::Document
  field :name, type: String
  field :cron, type: String
  # TODO validate cron string

  has_many :tasks
end
