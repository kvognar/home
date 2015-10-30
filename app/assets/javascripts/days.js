

$('#image-form').on('change', submitImage);

var submitImage = function() {
    $.ajax('/days', {
        contents: {
            photo: $('#image-form').val()
        }
    })

}
