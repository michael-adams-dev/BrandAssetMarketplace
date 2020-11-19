class SellerProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_seller_profile, except: [:index, :new, :create]

  def index
    @seller_profiles = SellerProfile.all.includes([brand_logo_attachment: :blob])
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

  def show
    @review = @seller_profile.reviews.new
  end

  def edit
  end

  def update
    @seller_profile.update(seller_profile_params)
    if @seller_profile.save
      redirect_to seller_profile_path(@seller_profile.id), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_seller_profile
      @seller_profile = SellerProfile.find(params[:id])
    end

    def seller_profile_params
      params.require(:seller_profile).permit(:brand_name, :brand_description, :brand_url, :contact_number, :contact_email, :brand_logo)
    end
end
