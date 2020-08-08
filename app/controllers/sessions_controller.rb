class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token, only: :create

    def new
        @player = Player.new
    end
  
    def create
      player = Player.find_by(username: params[:player][:username])
      player = player.try(:authenticate, params[:player][:password])
  
      return redirect_to(controller: 'players', action: 'new') unless player

      session[:player_id] = player.id
      session[:username] = player.username

      @player = player
      redirect_to player_path(@player)
    end

    def create_omni
      pp request.env['omniauth.auth']

      session[:name] = request.env['omniauth.auth']['info']['name']
      session[:omniauth_data] = request.env['omniauth.auth']

      redirect_to root_path
    end
  
    def destroy
      session.delete :player_id
      session.delete :username
  
      redirect_to '/'
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end