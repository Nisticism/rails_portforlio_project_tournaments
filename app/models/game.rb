class Game < ApplicationRecord
    has_many :tournaments
    has_many :players, through: :matches
    has_many :matches
    
end
