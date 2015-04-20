class Entry < ActiveRecord::Base
  attr_accessor :tag_string

  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 30 }




  def self.most_recent
    order("created_at DESC")
  end

  def self.search(search)
    where('title ILIKE ? OR body ILIKE ?', "%#{search}%", "%#{search}%")
  end

  def favorite_for(user)
    favorites.find_by_user_id(user.id) if user
  end

end
