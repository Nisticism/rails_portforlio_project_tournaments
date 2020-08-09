class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token, only: :create

    def new
      @player = Player.new
    end
  
    def create
      if auth_hash
        oauth_email = auth_hash['info']['email']
        name = auth_hash["info"]["name"]
        username = auth_hash['info']['nickname']
        if Player.find_by(:username => username)
          player = Player.find_by(:username => username)
          session[:player_id] = player.id
          redirect_to player_path(player)
        else
          player = Player.create(:name => name, :username => username, :email => oauth_email, :password => SecureRandom.hex)
          if player.save
            session[:player_id] = player.id
            redirect_to player_path(player)
          else
            flash[:error] = "User could not be authenticated from github.  Do you already have an account?"
            redirect_to new_player_path
          end
        end
      else

        player = Player.find_by(username: params[:player][:username])
        player = player.try(:authenticate, params[:player][:password])
    
        return redirect_to(controller: 'players', action: 'new') unless player

        session[:player_id] = player.id
        session[:username] = player.username

        redirect_to player_path(player)
      end
    end
  
    def destroy
      session.delete :player_id
      session.delete :username
      session.delete :omniauth_data
  
      redirect_to '/'
    end

    private

    def auth_hash
        request.env['omniauth.auth']
    end
end