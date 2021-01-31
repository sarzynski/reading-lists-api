require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  let!(:list) { create(:list) }
  let!(:books) { create_list(:book, 20, list_id: list.id) }
  let(:list_id) { list.id }
  let(:id) { books.first.id }

  describe 'GET /lists/:list_id/books' do
    before { get "/lists/#{list_id}/books" }

    context 'when list exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all books of list' do
        expect(json.size).to eq(20)
      end
    end

    context 'when list does not exist' do
      let(:list_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end

  describe 'GET /lists/:list_id/books/:id' do
    before { get "/lists/#{list_id}/books/#{id}" }

    context 'when list books exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when list book does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  describe 'POST /lists/:list_id/books' do
    let(:valid_attributes) { { title: 'Capital', author: 'Karl Marx', read: false } }

    context 'when request attributes are valid' do
      before { post "/lists/#{list_id}/books", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/lists/#{list_id}/books", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /lists/:list_id/books/:id' do
    let(:valid_attributes) { { title: 'Ksiazka' } }

    before { put "/lists/#{list_id}/books/#{id}", params: valid_attributes }

    context 'when book exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the book' do
        updated_book = Book.find(id)
        expect(updated_book.title).to match(/Ksiazka/)
      end
    end

    context 'when the book does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    before { delete "/lists/#{list_id}/books/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
