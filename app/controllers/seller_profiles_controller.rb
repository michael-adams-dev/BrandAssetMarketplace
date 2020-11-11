class SellerProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @seller_profiles = SellerProfile.all
  end

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    @seller_profile = SellerProfile.new(seller_profile_params)
    @seller_profile.user_id = current_user.id
    if @seller_profile.save
      redirect_to listings_path
    else
      render :new
    end
  end

  private

  def seller_profile_params
    params.require(:seller_profile).permit(:brand_name, :brand_description, :brand_url, :contact_number, :contact_email)
  end
end
