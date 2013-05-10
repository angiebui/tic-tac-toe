set :sockets, []

get '/game/:id' do

  @game = Game.find(params[:id])
  @player = 10
  if !request.websocket?
    erb :game
  else
    p "websocket detected"
    request.websocket do |ws|
      ws.onopen do
        p "Websocket Opened"
        # ws.send("{\"playerId\":#{@player}}") #.id 
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        p msg
        data = JSON.parse(msg)
        move = Move.create(game_id: data["game_id"], player_id: data["player_id"], coord: data["coord"])
        game = Game.find(data["game_id"])
        # winner = game.winner
        if winner
          EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
          #stop the game
        else
          EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
        end
      end

      ws.onclose do
        warn("websocket closed")
        settings.sockets.delete(ws)
      end
    end
  end

end

post '/game/:id/move' do
  Move.create(player_id: session[:id], coord: params[:coord], game_id: params[:id])
end

post '/game/:id/update' do
  content_type :json
  game = Game.find(params[:id])
  move = game.moves.last #the last player to move

  {coord: move.coord, previousPlayer: move.player_id}.to_json
end




get '/game/:id/info' do
  content_type :json
  player_id = session[:id]
  game = Game.find(params[:id])
  letter = (game.player_one.id == session[:id] ? 'X' : 'O')
  {game_id: game.id, player_id: player_id, letter: letter}.to_json


end
