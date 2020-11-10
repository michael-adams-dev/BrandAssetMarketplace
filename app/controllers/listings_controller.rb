class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.seller_profile.listings.new(listing_params)
    if @listing.save
      redirect_to listings_path
    else
      render :new
    end
  end


  private

  def listing_params
    params.require(:listing).permit(:title, :description, :quantity, :price)
  end
end
