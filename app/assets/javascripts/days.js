# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('#image-form').on('submit', submitImage);

submitImage = function(event) {
  event.preventDefault();

}
