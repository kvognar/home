µ = {};

$(document).on('turbolinks:load', function () {
  $('#rss').on('click', function (event) {
    event.preventDefault();
    alert('To subscribe to my RSS feed, add this to your feed reader:\nhttp://kevinvognar.com/feed.rss')
  });
  $('.searchable-select').select2({
    tags: true,
    width: '100%'
  });
  if ($('.select2').length === 0) {
    $('.tag-picker').select2({width: '100%'});
  }

  $('.expand').on('click', function (event) {
    if (event.target === event.currentTarget) {
      event.preventDefault();
    }
    let newState = !$(event.currentTarget).hasClass('expanded');
    $('.expand').removeClass('expanded')
    if (newState) {
      $(event.currentTarget).addClass('expanded');
    }
  })
});

