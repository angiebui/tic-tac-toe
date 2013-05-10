// Game = {id:1, letter:'X', playerId: 1}; // Player # and Corresponding Letter and Game id
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
}



var parseMessage = function(m){
  var data = JSON.parse(m.data);
  if(data.playerId != Game.playerId){
    updateBoard(data.coord, data.letter);
    turnOnClick();
  }
};

socket.onmessage = parseMessage;

var updateBoard = function(coord, letter){
  clickedBox = $('#'+coord);
  clickedBox.html(letter);
  clickedBox.removeClass('clickable');
  $('.clickable').unbind('click');
};

$(document).ready(function(){
  $.get(window.location.pathname + '/info').done(function(data){
    Game = data;
    if(Game.letter == 'X'){ // check if player 1
      turnOnClick();
    }
  });
});
