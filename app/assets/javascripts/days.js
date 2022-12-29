$(document).on('turbolinks:load', function () {
	if ($('body.days').length || $('body.tags').length) {
		µ.readyDaysJs();
	}
});

µ.readyDaysJs = function () {
	$('.favorite-toggle').on('click', µ.toggleFavorite);
};


µ.toggleFavorite = function (event) {
	event.preventDefault();

	const $button = $(event.currentTarget);

	$.ajax({
		type: 'PUT',
		url: '/api/days/' + $button.data('day-id') + '/toggle_favorite',
		success: function(response) {
			if (response.favorited) {
				$button.addClass('favorited');
			} else {
				$button.removeClass('favorited');
			}
		},
		error: function(response) {
			console.log(response);
			alert(response.responseJSON.error);
		}
	})
}
