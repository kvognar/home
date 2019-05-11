µ.readyTagAdmin = function() {
    $('.tags-admin').on('click', '.feature-toggle', µ.toggleTagFavorite);
};

$(document).on('turbolinks:load', µ.readyTagAdmin);

µ.toggleTagFavorite = function(event) {
    $target = $(event.currentTarget);
    $.ajax({
        type: 'put',
        url: '/admin/tags/' + $target.data('id'),
        data: { tag: { featured: !$target.hasClass('featured')}},
        success: (_response => $target.toggleClass('featured'))
    });
};
