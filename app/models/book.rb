class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(method,word)
    if method == "perfect_match"
      @users = Book.where(title: "#{word}")
    elsif method == "forward_match"
      @users = Book.where("title LIKE?", "#{word}%")
    elsif method == "backward_match"
      @users = Book.where("title LIKE?", "%#{word}")
    elsif method == "partial_match"
      @users = Book.where("title LIKE?", "%#{word}%")
    else
      @users = Book.all
    end
  end
end
