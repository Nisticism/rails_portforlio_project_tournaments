class Player < ApplicationRecord
    
    has_secure_password

    has_many :matches
    has_many :tournaments
    has_many :games, through: :matches
end
