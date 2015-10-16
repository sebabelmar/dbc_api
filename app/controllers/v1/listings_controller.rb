class V1::ListingsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index]

  # GET /v1/listings
  # Get all the stories
  def index
    @listings = Listing.includes(:user).order(created_at: :desc).all
    render json: @listings
  end

  def show
    @listing = Listing.find(params[:id])
    render json: @listing
  end

  # POST /v1/listings
  # Add a new story
  def create
    @listing = Listing.new(item_params)

    if @listing.save
      render json: @listing
    else
      render json: { error: t('story_create_error') }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:listing).permit(:title, :description, :price, :location, :experation_date).merge(user: current_user)
  end
end
