class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @farmer = Farmer.find(params[:farmer_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.farmer = @farmer
    if @review.save!
      redirect_to farmer_path(@farmer)
    else
      flash[:alert] = "Something went wrong."
      render "services/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
