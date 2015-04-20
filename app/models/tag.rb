class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :entries, through: :taggings

  validates :name, presence: :true
  validates_uniqueness_of :name, scope: :id

end
