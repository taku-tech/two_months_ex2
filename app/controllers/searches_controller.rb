class SearchesController < ApplicationController
	def search
		@model = params[:search_model]
		if @model == "user_match"
			method = params[:search_method]
			@word = params[:search_word]
			@users = User.search(method,@word)
		elsif @model == "book_match"
			method = params[:search_method]
			@word = params[:search_word]
			@books = Book.search(method,@word)
		end
	end
end
