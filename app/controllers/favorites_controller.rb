class FavoritesController < ApplicationController
	before_action :authenticate_user!

	def create
		book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: book.id)
        if favorite.save
		 	redirect_back(fallback_location: user_path(current_user))
		end
	end

	def destroy
		book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: book.id)
        if favorite.destroy
        	redirect_back(fallback_location: user_path(current_user))
        end
	end
end
