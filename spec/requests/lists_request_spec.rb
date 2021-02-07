require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  let(:user) { create(:user) }
  let!(:lists) { create_list(:list, 10, created_by: user.id) }
  let(:list_id) { lists.first.id }
  let(:headers) { valid_headers }

  describe 'GET /lists' do
    before { get '/lists', params: {}, headers: headers }

    it 'returns lists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /lists/:id' do
    before { get "/lists/#{list_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the list' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(list_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:list_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end

  describe 'POST /lists' do
    let(:valid_attributes) do
      { name: "Lista", created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/lists', params: valid_attributes, headers: headers }

      it 'creates a list' do
        expect(json['name']).to eq('Lista')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/lists', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /lists/:id' do
    let(:valid_attributes) { { name: 'Ksiazki'}.to_json }

    context 'when the record exists' do
      before { put "/lists/#{list_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    before { delete "/lists/#{list_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

