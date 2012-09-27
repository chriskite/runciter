require 'spec_helper'

module Runciter
  describe App do
    it 'works' do
      app = App.new(
        'Spec App',
        SPEC_URL,
        :cron => '30 * * * *',
        :alert => 'test@example.com'
      )
      app.task('Try Things', :steps => 10) do |r|
        10.times { sleep 1; r.step! }
      end
    end
  end
end
