class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :hide]
  
  def index
    if params[:search].present?
      @listings = Listing.where(nil)
      @listings = @listings.search_by_title(params[:search][:title]) if params[:search][:title].present?
      @listings = @listings.search_by_category(params[:search][:category]) if params[:search][:category].present?
    else
      @listings = Listing.all
    end
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

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description,
        images: [@listing.image],
        amount: (@listing.price * 100).to_i,
        currency: 'aud',
        quantity: @listing.quantity
      }],
      payment_intent_data: {
        metadata: {
          event_id: @listing.id
        }
      },
      success_url: "#{root_url}payments/success?eventId=#{@listing.id}",
      cancel_url: "#{root_url}"
    )
    @session_id = session.id
  end

  def edit
  end

  def update
  end

  def hide
    if @listing.hidden
      @listing.update_attribute(:hidden, false)
    else
      @listing.update_attribute(:hidden, true)
    end
    redirect_to @listing
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :quantity, :price, :image, :hidden, :category_id)
    end
end
