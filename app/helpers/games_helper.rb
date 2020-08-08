module GamesHelper
    #  For tournaments
    def display_game(tournament)
      tournament.game.nil? ? link_to("Add Game", edit_tournament_path(tournament)) : link_to(tournament.game_title, game_path(tournament.game))
    end
  end