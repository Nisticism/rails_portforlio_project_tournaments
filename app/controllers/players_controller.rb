class PlayersController < ApplicationController
    before_action :set_player, except: [:new, :create]

    def new
        @player = Player.new
    end
  
    def create
      @player = Player.new(player_params)
      if @player.save
        session[:player_id] = @player.id
        redirect_to player_path(@player)
      else
        render :new
      end
    end

    def show
      @player = Player.find(params[:id])

      if params[:leave] == "true"
        @tournament = Tournament.find_by(:id => params[:tournament])
        @player.tournaments.delete(@tournament)
        redirect_to player_path(@player)
      end

    end

    def index
      @players = Player.all
    end

    def edit
    end

    def update
      @player.update(player_params)
      redirect_to player_path(@player)
    end

    private

    def logged_in?
      if session[:player_id]
          true
      else
          false
      end
  end

  def set_player
      if logged_in?
          @player = Player.find(session[:player_id])
      else
          flash[:error] = "Error: Please log in or sign up first."
          redirect_to new_player_path
      end
  end
  
    def player_params
      params.require(:player).permit(:username, :password, :password_confirmation, :name, :email)
    end
end
