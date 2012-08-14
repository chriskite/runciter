class Task
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  belongs_to :app
  has_many :runs
end
