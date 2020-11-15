class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @parent = parent
    @review = @parent.reviews.new(review_params)
    if @review.save
      redirect_to @parent
    else 
      render :new
    end
  end

  private

  def parent
    return Listing.find(params[:listing_id]) if params[:listing_id]
    SellerProfile.find(params[:seller_profile_id]) if params[:seller_profile_id]
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment).merge(user_id: current_user.id)
  end
end
