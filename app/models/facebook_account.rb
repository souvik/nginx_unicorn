class FacebookAccount < ActiveRecord::Base
  belongs_to :user

  validates :identifier, presence: true, uniqueness: true
end
