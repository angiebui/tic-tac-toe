set :server, 'thin'
set :sockets, []
before do
  @current_player = current_player
end


get '/' do
  if !request.websocket?
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        # ws.send("Hello World!")
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


post '/signin' do
  current_player = Player.find_or_create_by_name(params[:name])
  session[:id] = current_player.id
  redirect to('/')
end
