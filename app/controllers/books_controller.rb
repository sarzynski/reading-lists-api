class BooksController < ApplicationController
  before_action :set_list
  before_action :set_list_book, only: [:show, :update, :destroy]

  def index
    json_response(@list.books)
  end

  def show
    json_response(@book)
  end

  def create
    @list.books.create!(book_params)
    json_response(@list, :created)
  end

  def update
    @book.update(book_params)
    head :no_content
  end

  def destroy
    @book.destroy
    head :no_content
  end

  private

  def book_params
    params.permit(:title, :author, :read)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_list_book
    @book = @list.books.find_by!(id: params[:id]) if @list
  end
end
