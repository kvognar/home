//= require dropzone

µ = {};

Dropzone.autoDiscover = false;

$(function() {
    if($('#photo-dropzone').length) {
        var photoUpload = new Dropzone('#photo-dropzone');
        photoUpload.on('success', µ.showPhoto);
    }

    $('.good-night').on('click', µ.submitDay);

    $('.day-data-container-toggle').on('click', function(event) {
        event.preventDefault();
        $('.day-data-container').toggleClass('glass');
    })

});

// Triggers


µ.submitDay = function(event) {
    event.preventDefault();
    var dayForm = $('#day-form');
    $.ajax({
        type: dayForm.data('method'),
        url: dayForm.attr('action'),
        data: dayForm.serialize(),
        success: µ.handleSubmissionResponse,
        error: µ.print_errors
    });
};

µ.showPhoto = function(file, response) {
    $('#photo-container').append('<img class="photo-preview" src="' + response.url + '">');
    $('#day-form').append('<input type="hidden" name="photo[id]" value="' + response.id + '">' );
    $('.dropzone').hide();
};

// Response callbacks

µ.add_link_to_day = function(response) {
    $('.continue-container').html('<a class="sleep-well" target="_blank" href=' + response.url + '>Sleep well.</a>')
};

µ.handleSubmissionResponse = function(response) {
    µ.add_link_to_day(response);
    µ.setFormToEditMode(response);
};

µ.print_errors = function(response) {
    $('.error-container').html('<ul></ul>');
    response.responseJSON.errors.forEach(function(error) {
        $('.error-container ul').append('<li>' + error + '</li>')
    })
};

// Helper methods

µ.setFormToEditMode = function(response) {
    var dayForm = $('#day-form');
    dayForm.attr('action', response.update_url);
    dayForm.data('method', 'PUT');
    dayForm.append('<input type="hidden" name="id" value="' + response.id + '">');
};
