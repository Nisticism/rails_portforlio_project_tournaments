class PlayersController < ApplicationController

    def new
    end
  
    def create
      @player = Player.create(player_params)
      return redirect_to controller: 'players', action: 'new' unless @player.save
      session[:player_id] = @player.id
      redirect_to controller: 'players', action: 'show'
    end
  
    private
  
    def player_params
      params.require(:player).permit(:username, :password, :password_confirmation)
    end

    def show
        @player = Player.find_by(id: params[:id])
        Match
        @most_played_game
    end

end
