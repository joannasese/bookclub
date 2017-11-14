class ReviewsController < ApplicationController
  before_action :current_user, only: :destroy
  include ReviewsHelper

  def index #do i even really need an index?
    @review = Review.all
  end

  def new
    @review = Review.new
  end
 
  def create
    find_book
    @review = @book.reviews.build(review_params)
    @review.user = current_user
    if @review.save
     flash[:success] = "Thanks for the review!"
     redirect_to book_path(@book)
    else
     render :new
    end
  end

  def edit
    find_book
    @review = @book.reviews.find(params[:id])
  end

  def update
    @review = @book.reviews.update(review_params)

    if @review
      flash[:success] = "Review Updated!"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "Unsuccessful update!"
      render :edit
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    flash[:success] = "Review deleted"
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating, :user_id, :book_id)
  end

end
