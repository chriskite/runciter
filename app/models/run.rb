class Run
  include Mongoid::Document
  field :steps, type: Integer
  field :steps_done, type: Integer
  field :heartbeat_interval, type: Integer
  field :last_heartbeat, type: Time
  field :finished_at, type: Time
  field :state, type: String
  field :message, type: String

  belongs_to :task
end
