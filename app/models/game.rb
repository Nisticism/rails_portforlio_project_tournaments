class Game < ApplicationRecord

    has_many :tournaments
    has_many :players, through: :tournaments

    accepts_nested_attributes_for :tournaments
    accepts_nested_attributes_for :players

    validates :genre, :title, presence: true
    validates :title, uniqueness: true
    validates :genre, inclusion: { in: %w(rts rpg fps fighting FPS Fighting RTS RPG),
    message: "Invalid genre, genre must be RTS, RPG, Fighting, or FPS" }

end
