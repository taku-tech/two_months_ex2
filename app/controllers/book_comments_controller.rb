class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
    	@book_comment = current_user.book_comments.new(book_comment_params)
    	@book_comment.book_id = @book.id
    	if @book_comment.save
    		redirect_to book_path(@book)
    	else
    		render 'books/show'
    	end
	end

	def destroy
		book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
		book_comment.destroy
    	redirect_to book_path(params[:book_id])
	end

	private

	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

end
