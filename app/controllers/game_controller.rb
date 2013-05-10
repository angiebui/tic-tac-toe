set :sockets, []

get '/game/:id' do
  @game = Game.find(params[:id])

  if !request.websocket?
    erb :game
  else
    p "websocket detected"
    request.websocket do |ws|
      ws.onopen do
        ws.send("Hello World!")
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
      end
      ws.onclose do
        warn("wetbsocket closed")
        settings.sockets.delete(ws)
      end
    end
  end

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




get '/' do
  
end
