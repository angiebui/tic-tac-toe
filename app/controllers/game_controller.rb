





get '/game/:id' do
  @game = Game.find(params[:id])

  erb :game
end

post '/game/:id/move' do
  

end
