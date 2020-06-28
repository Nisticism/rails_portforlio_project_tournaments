class Tournament < ApplicationRecord
    has_many :matches
    belongs_to :game
    has_many :players

    def game_title
        self.try(:game).try(:title)
    end

    def game_title=(title)
        game = Game.find_or_create_by(title: title)
        self.game = game
    end

end
