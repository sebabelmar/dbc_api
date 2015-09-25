class V1::ItemsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  # GET /v1/items
  # Get all the stories
  def index
    @items = Item.includes(:user).order(created_at: :desc).all
    render json: @items
  end

  def show
    @item = Item.find(params[:id])
    render json: @item
  end

  # POST /v1/items
  # Add a new story
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item
    else
      render json: { error: t('story_create_error') }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price).merge(user: current_user)
  end
end
