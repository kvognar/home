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
    });

    $('.media_works').on('click', '.badge-toggle', µ.toggleBadge);
};

$(document).on('turbolinks:load', function() {
    if ($('body.media_works').length) {
        µ.readyMediaWorks();
    }
});

µ.toggleBadge = function(event) {
    const $target = $(event.currentTarget);
    console.log($target.data());
    $.ajax({
        type: 'put',
        url: '/api/media_work_badges/toggle',
        data: {
            badge_id: $target.data('badgeId'),
            media_work_id: $target.data('mediaWorkId')
        },
        success: (_response => $target.toggleClass('selected'))
    });
};
