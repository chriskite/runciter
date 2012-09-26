class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String

  belongs_to :app
  has_many :runs
end
