class Player < ApplicationRecord

    has_many :created_tournaments, class_name: "Tournaments"

    has_secure_password

    validates :name, :username, :password_digest, presence: true
    validates :username, uniqueness: true

    has_many :tournament_signups
    has_many :tournaments, through: :tournament_signups
    has_many :games, through: :tournaments

    accepts_nested_attributes_for :tournaments, :games

    scope :short_username, -> {where("LENGTH(username) < 6")}

end
