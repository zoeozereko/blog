class Comment < ActiveRecord::Base
  belongs_to :entry

  validates :body, presence: true
  validates_uniqueness_of :body, scope: :entry_id

  default_scope -> { order(created_at: :desc) }

end
