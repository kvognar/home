//= require dropzone


Dropzone.autoDiscover = false;

$(function() {
    var photoUpload = new Dropzone('#photo-dropzone');
    photoUpload.on('success', function(file, response) {
        $('#photo-container').append('<img class="photo-preview" src="' + response.url + '">');
        $('#new_day').append('<input type="hidden" name="photo[id]" value="' + response.id + '">' );
        $('.dropzone').hide();
    });


});
