class BookCommentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:destroy]
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comments_params)
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    BookComment.find(params[:book_id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def book_comments_params
    params.require(:book_comment).permit(:comment)
  end
  
  def correct_user
    BookComment.find(params[:book_id])
    if current_user.id != @comment.user.id
    redirect_to books_path
    end
  end
end
