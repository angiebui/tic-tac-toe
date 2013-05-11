var socket = new WebSocket("ws://localhost:9292" + window.location.pathname);
var Game;

var turnOnClick = function(){
  //alert player it's their turn
  $('.clickable').click(function(){
    var coord = $(this).attr('id');
    updateBoard(coord, Game.letter);
    console.log(Game);
    var data = {coord: coord, game_id: Game.game_id, player_id: Game.player_id , letter: Game.letter};
    console.log(data)
    socket.send(JSON.stringify(data));
  });
};

var doWinner = function(data){
  $('#'+data.coord).html(data.letter);
  $('.container').append(data.winner_name+' has won!');
};

var doDraw = function(data){
  $('.container').append('Draw!');
};

var parseMessage = function(m){
  var data = JSON.parse(m.data);
  console.log(data);
  if(data.winner_id){
    doWinner(data);
  } else if (data.draw) {
    doDraw(data);
  }else if(data.player_id != Game.player_id){
    updateBoard(data.coord, data.letter);
    turnOnClick();
  }
};

socket.onmessage = parseMessage;

var updateBoard = function(coord, letter){
  clickedBox = $('#'+coord);
  clickedBox.html(letter);
  $('.clickable').unbind('click');
  clickedBox.removeClass('clickable');
};

$(document).ready(function(){
  $.get(window.location.pathname + '/info').done(function(data){
    Game = data;
    if(Game.letter == 'X'){ // check if player 1
      turnOnClick();
    }
  });
});
