Game = {id:1, letter:'X'} // Player # and Corresponding Letter and Game id


var updateBoard = function(clickedBox){
  clickedBox.html(Game.letter);
  clickedBox.removeClass('clickable');
  $('.clickable').unbind('click');
};


$(document).ready(function(){
  $('.clickable').click(function(){
    updateBoard($(this));

  });
});
