require 'spec_helper'

module Runciter
  describe App do
    it 'works' do
      app = App.new('Test', SPEC_URL)
      app.task('Try Things', :steps => 10) do |r|
        10.times { r.step }
      end
    end
  end
end
