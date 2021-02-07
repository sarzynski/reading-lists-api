class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    @lists = current_user.lists
    json_response(@lists)
  end

  def create
    @list = current_user.lists.create!(list_params)
    json_response(@list, :created)
  end

  def show
    json_response(@list)
  end

  def update
    @list.update(list_params)
    head :no_content
  end

  def destroy
    @list.destroy
    head :no_content
  end

  private

  def list_params
    params.permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end