get '/game/:id' do
  @game = Game.find(params[:id])

  erb :game
end

post '/game/:id/move' do
  Move.create(player_id: session[:player_id], coord: params[:coord], game_id: params[:id])
end

post '/game/:id/update' do
  content_type :json
  game = Game.find(params[:id])
  move = game.moves.last #the last player to move

  {coord: move.coord, previousPlayer: move.player_id}.to_json
end
