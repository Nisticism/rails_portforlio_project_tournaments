class TournamentsController < ApplicationController

    def index

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
    
    def show

        if params[:game_id]
            @game = Game.find_by(id: params[:game_id])
            @tournament = @game.tournaments.find_by(id: params[:id])
            if @tournament.nil?
                redirect_to game_tournaments_path(@game), alert: "Tournament not found"
            end
        else
            @tournament = Tournament.find(params[:id])
        end
        
    end
    
    def new
    # if params[:artist_id] && !Artist.exists?(params[:artist_id])
    #     redirect_to artists_path, alert: "Artist not found"
    # else
    #     @song = Song.new(artist_id: params[:artist_id])
    # end
        if params[:game_id] && !Game.exists?(params[:game_id])
            redirect_to games_path, alert: "Game not found"
        else
            @tournament = Tournament.new(game_id: params[:game_id])
        end
    end
    
    def create
    # @song = Song.new(song_params)

    # if @song.save
    #     redirect_to @song
    # else
    #     render :new
    # end

        @tournament = Tournament.new(tournament_params)

        if @tournament.save
            redirect_to @tournament
        else
            render :new
        end

    end

    def edit
        if params[:game_id]
            game = Game.find_by(id: params[:game_id])
            if game.nil?
                redirect_to games_path, alert: "Game not found"
            else
                @tournament = game.tournaments.find_by(id: params[:id])
                redirect_to game_tournaments_path(game), alert: "Tournament not found" if @tournament.nil?
            end
        else
            @tournament = Tournament.find(params[:id])
        end
    end
    
    def update
    # @song = Song.find(params[:id])

    # @song.update(song_params)

    # if @song.save
    #   redirect_to @song
    # else
    #   render :edit
    # end
    end
    
    def destroy
    # @song = Song.find(params[:id])
    # @song.destroy
    # flash[:notice] = "Song deleted."
    # redirect_to songs_path
    end
    
    private

    def tournament_params
        params.require(:tournament).permit(:name, :game_title, :game_id)
    end
end
