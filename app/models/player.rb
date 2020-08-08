class Player < ApplicationRecord

    has_secure_password

    validates :name, :username, :email, :password_digest, presence: true
    validates :username, uniqueness: true

    has_many :tournament_signups
    has_many :tournaments, through: :tournament_signups
    has_many :games, through: :tournaments

    accepts_nested_attributes_for :tournaments, :games

    scope :has_email, -> {where(has_email: true)}
    # scope :has_matches, -> {where(games.count > 0)}

end
