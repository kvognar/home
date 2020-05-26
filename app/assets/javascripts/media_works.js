// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

µ.readyMediaWorks = function () {
    $('.spoiler-toggle').on('click', function(event) {
        event.preventDefault();
        $('.spoilers').toggleClass('hidden');
        $('.spoiler-warning').toggleClass('hidden');
        if ($('.spoilers').hasClass('hidden')) {
            $(event.currentTarget).text('Show Spoilers');
        } else {

        $(event.currentTarget).text('Hide Spoilers')
        }
    })
}

$(document).on('turbolinks:load', function() {
    if ($('body.media_works.show').length) {
        µ.readyMediaWorks();
    }
});
