require 'rails_helper'

RSpec.describe TwitterAccount do
  describe 'realtionships' do
    it { should belong_to :user }
    it { should have_many :tweets }
  end
end