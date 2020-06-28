class Match < ApplicationRecord
    has_many :players
    belongs_to :game
end
