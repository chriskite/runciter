class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String

  belongs_to :app
  embeds_many :runs
  index 'runs.state' => 1 # used by the daemon

  before_save do
    runs = runs[1..30] if !!runs
  end
end
