class User < ApplicationRecord
  # validates :username, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  has_many :votes
  has_many :works, through: :votes, dependent: :destroy

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.name = auth_hash["info"]["name"]
    user.email = auth_hash["info"]["email"]

    # Note that the user has not been saved.
    # We'll choose to do the saving outside of this method
    return user
  end
end
