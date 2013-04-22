class Task
  RUN_LIMIT = 15

  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String

  belongs_to :app
  embeds_many :runs
  index 'runs.state' => 1 # used by the daemon

  def trim_runs!
    if runs.count > RUN_LIMIT
      pop(:runs, -1)
    end
  end
end
