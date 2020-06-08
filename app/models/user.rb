class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローする側から見たrelationship
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # フォローされる側から見たrelationship
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :address_building, presence: true
  after_validation :geocode

  # geocoded_by :address
  # after_validation :geocode, if: :address_changed?

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(method,word)
    if method == "perfect_match"
      @users = User.where(name: "#{word}")
    elsif method == "forward_match"
      @users = User.where("name LIKE?", "#{word}%")
    elsif method == "backward_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif method == "partial_match"
      @users = User.where("name LIKE?", "%#{word}%")
    else
      @users = User.all
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address
    "%s %s"%([self.prefecture_code, self.address_city, self.address_street, self.address_building])
  end

  geocoded_by :address
  after_validation :geocode
end
