class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    @lists = List.all
    json_response(@lists)
  end
end
