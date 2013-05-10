$(document).ready(function() {
  var ws       = new WebSocket('ws://' + window.location.host + window.location.pathname);
  // ws.onopen    = function()  { show('websocket opened'); };
  // ws.onclose   = function()  { show('websocket closed'); };
  ws.onmessage = function(msg) { showMsg(msg.data); };

  $('form#form').on('submit',function(e){
    e.preventDefault();
    var msg = '{"name":'+'"'+$('input#name').val()+'"'+', "input":'+'"'+$('input#input').val()+'"'+'}';
    // console.log($.parseJSON(msg))
    // console.log(msg);
    ws.send(msg);
  });
});


var  show = function(el) {
  $('#msgs').append("<p>"+el+"</p>");
  };

var showMsg = function(msg) {
  console.log($.parseJSON(msg));
}
