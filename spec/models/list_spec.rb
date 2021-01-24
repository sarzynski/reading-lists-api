require 'rails_helper'

RSpec.describe List, type: :model do
  it { should have_many(:books).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
