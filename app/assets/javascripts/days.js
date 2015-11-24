//= require dropzone

µ = {};

Dropzone.autoDiscover = false;

$(function() {
    var photoUpload = new Dropzone('#photo-dropzone');
    photoUpload.on('success', function(file, response) {
        $('#photo-container').append('<img class="photo-preview" src="' + response.url + '">');
        $('#new_day').append('<input type="hidden" name="photo[id]" value="' + response.id + '">' );
        $('.dropzone').hide();
    });

    $('.good-night').on('click', function (event) {
        event.preventDefault();
        $.ajax({
            type: 'POST',
            url: $('#new_day').attr('action'),
            data: $('#new_day').serialize(),
            success: µ.add_button_to_day,
            error: µ.print_errors
        });
    });

    $('.day-data-container-toggle').on('click', function(event) {
        $('.day-data-container').toggleClass('glass');
    })

});


µ.add_button_to_day = function(response) {
    $('.continue-container').html('<a class="sleep-well" href=' + response.url + '>Sleep well.</a>')
}

µ.print_errors = function(response) {
    $('.error-container').html('<ul></ul>')
    response.responseJSON.errors.forEach(function(error) {
        $('.error-container ul').append('<li>' + error + '</li>')
    })
}
