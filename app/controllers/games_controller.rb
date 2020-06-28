class GamesController < ApplicationController
    def index
        # @artists = Artist.all
        @games = Game.all
    end

    def show
        @game = Game.find(params[:id])
    end

    def new
        @game = Game.new
    end

    def create
    # @artist = Artist.new(artist_params)

    # if @artist.save
    #     redirect_to @artist
    # else
    #     render :new
    # end

        @game = Game.new(game_params)
        
        if @game.save
            redirect_to @game
        else
            render :new
        end
        
    end

    def edit
        # @artist = Artist.find(params[:id])
        @game = Game.find(params[:id])
    end

    def update
    # @artist = Artist.find(params[:id])

    # @artist.update(artist_params)

    # if @artist.save
    #     redirect_to @artist
    # else
    #     render :edit
    # end
    end

    def destroy
    # @artist = Artist.find(params[:id])
    # @artist.destroy
    # flash[:notice] = "Artist deleted."
    # redirect_to artists_path
    end

    private

    def game_params
        params.require(:game).permit(:title)
    end
end
