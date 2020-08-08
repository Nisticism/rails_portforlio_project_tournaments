require 'pry'
class GamesController < ApplicationController

    before_action :set_player
    before_action :set_game, except: [:new, :create, :index]

    def index
        @games = Game.all
    end

    def show

        if params[:join] == "true"
            @tournament = Tournament.find_by(:id => params[:tournament])
            @tournament.players << @player
            redirect_to game_path(@game)
        elsif params[:leave] == "true"
            @tournament = Tournament.find_by(:id => params[:tournament])
            @tournament.players.delete(@player)
            redirect_to game_path(@game)
        end
    end

    def new
        @game = Game.new
    end

    def create
        @game = Game.new(game_params)
        
        if @game.save
            redirect_to @game
        else
            render :new
        end
        
    end

    def edit
    end

    def update
        @game.update(game_params)

        if @game.save
            redirect_to @game
        else
            render :edit
        end
    end

    def destroy
        @game.destroy
        flash[:notice] = "Game deleted."
        redirect_to games_path
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

    def set_game
        @game = Game.find(params[:id])
    end

    def game_params
        params.require(:game).permit(:title, :release_date, :genre)
    end
end
