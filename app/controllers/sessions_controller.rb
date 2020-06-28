class SessionsController < ApplicationController
    def new
    end
  
    def create
      player = Player.find_by(username: params[:player][:username])
  
      player = player.try(:authenticate, params[:player][:password])
  
      return redirect_to(controller: 'sessions', action: 'new') unless player
  
      session[:player_id] = player.id
  
      @player = player
  
      redirect_to controller: 'welcome', action: 'home'
    end
  
    def destroy
      session.delete :player_id
  
      redirect_to '/'
    end
end