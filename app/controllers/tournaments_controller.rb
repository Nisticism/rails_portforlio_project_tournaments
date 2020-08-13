require 'pry'
class TournamentsController < ApplicationController
    before_action :set_player, except: [:index]
    before_action :set_tournament, except: [:new, :create, :index]

    def index
        if logged_in?
            set_player
        end
        if params[:game_id]
            @game = Game.find_by(id: params[:game_id])
            if @game.nil?
                redirect_to games_path, alert: "Game not found"
            else
                @tournaments = @game.tournaments
            end
        else
            @tournaments = Tournament.all
        end
    end
    
    def new
        if params[:game_id] && !Game.exists?(params[:game_id])
            redirect_to games_path, alert: "Game not found"
        elsif params[:game_id] && Game.exists?(params[:game_id])
            @game = Game.find_by(id: params[:game_id])
            @tournament = @game.tournaments.build
        else
            @tournament = Tournament.new
        end
    end
    
    def create
        if Game.exists?(params[:tournament][:game])
            @game = Game.find_by(id: params[:tournament][:game])
            @tournament = @game.tournaments.build(tournament_params)
        else
            @tournament = Tournament.new(tournament_params)
        end

        if params[:creator]
            @tournament.creator = Player.find_by(id: params[:creator].to_i)
        end


        if @tournament.save
            redirect_to tournament_path(@tournament)
        else
            render :new
        end

    end

    def show

        if params[:game_id]
            @game = Game.find_by(id: params[:game_id])
            @tournament = @game.tournaments.find_by(id: params[:id])
            if @tournament.nil?
                redirect_to game_tournaments_path(@game), alert: "Tournament not found"
            end
        end

        if params[:join] == "true"
            @tournament.players << @player
            redirect_to tournament_path(@tournament)
        elsif params[:leave] == "true"
            @tournament.players.delete(@player)
            redirect_to tournament_path(@tournament)
        end
        
    end

    def edit
        if @tournament.creator == @player
            if params[:game_id]
                game = Game.find_by(id: params[:game_id])
                if game.nil?
                    redirect_to games_path, alert: "Game not found"
                else
                    @tournament = game.tournaments.find_by(id: params[:id])
                    redirect_to game_tournaments_path(game), alert: "Tournament not found" if @tournament.nil?
                end
            end
        else
            flash[:alert] = "Must be the tournament creator in order to edit tournaments."
            redirect_to tournaments_path
        end
    end
    
    def update
        @game = Game.find_by(id: params[:tournament][:game])
        @tournament.update(tournament_params)
        @tournament.update(game: @game)
        redirect_to tournament_path(@tournament)
    end
    
    def destroy
        @tournament.destroy
        flash[:notice] = "Tournament deleted."
        redirect_to tournaments_path
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

    def set_tournament
        @tournament = Tournament.find(params[:id])
    end

    def tournament_params
        params.require(:tournament).permit(:name, :game_id, :game_title, :start_date, :prize_pool, :creator)
    end
end
