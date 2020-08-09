class Tournament < ApplicationRecord

    has_many :tournament_signups
    has_many :players, through: :tournament_signups
    belongs_to :game

    validates :start_date, :name, :prize_pool, presence: true
    validates :name, uniqueness: true

    scope :major_prize_pool, -> {where("prize_pool > 1000")}
    scope :future_tournaments, -> (time) {where("start_date > ?", time)}

    def game_title
        self.try(:game).try(:title)
    end

    def game_title=(title)
        game = Game.find_or_create_by(title: title)
        self.game = game
    end



end
