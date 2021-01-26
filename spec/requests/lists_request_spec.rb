require 'rails_helper'

RSpec.describe "Lists", type: :request do
  let!(:lists) { create_list(:list, 10) }
  let(:list_id) { lists.first.id }

  describe 'GET /lists' do
    before { get '/lists' }

    it 'returns lists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

