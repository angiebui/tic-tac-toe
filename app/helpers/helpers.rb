def current_player
  @current_player ||= Player.find(session[:id]) if session[:id]
end
