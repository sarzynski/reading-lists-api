require 'rails_helper'

RSpec.describe 'Lists', type: :request do
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

  describe 'GET /lists/:id' do
    before { get "/lists/#{list_id}" }

    context 'when the record exists' do
      it 'returns the list' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(list_id)
      end
    end
  end
end

