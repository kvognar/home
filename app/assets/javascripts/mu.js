µ = {};

$(document).on('page:change', function() {
    $('#rss').on('click', function(event) {
        event.preventDefault();
        alert('To subscribe to my RSS feed, add this to your feed reader:\nhttp://kevinvognar.com/feed.rss')
    });
});
