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
    });

    $('.comments').on('click', '.submit-comment', µ.submitComment);

    $('.reply-link').on('click', µ.showCommentForm);

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
        error: µ.printErrors
    });
};

µ.showPhoto = function(file, response) {
    $('#photo-container').append('<img class="photo-preview" src="' + response.url + '">');
    $('#day-form').append('<input type="hidden" name="photo[id]" value="' + response.id + '">' );
    $('.dropzone').hide();
};

µ.showCommentForm = function(event) {
    event.preventDefault();
    var $parentComment = $(event.currentTarget).parent();
    var $newForm =$('#comment-form-template').clone();
    $newForm.attr('id', null);
    $newForm.find('input#comment_parent_id').val($parentComment.data('id'));
    $parentComment.append($newForm);
    $(event.currentTarget).remove();
};

µ.submitComment = function(event) {
    event.preventDefault();
    if ($('.humanity-check').prop('checked')) {
        var commentForm = $('.comment-form');
        $.ajax({
            type: commentForm.data('method'),
            url: commentForm.attr('action'),
            data: commentForm.serialize(),
            success: µ.handleCommentResponse,
            error: µ.printErrors
        });
    } else {
        alert("No commenting unless you're a person!")
    }
};

// Response callbacks

µ.addLinkToDay = function(response) {
    $('.continue-container').html('<a class="sleep-well" target="_blank" href=' + response.url + '>Sleep well.</a>')
};

µ.handleSubmissionResponse = function(response) {
    µ.addLinkToDay(response);
    µ.setFormToEditMode(response);
};

µ.handleCommentResponse = function(response) {
    $('.comments').append("Thanks! Your comment will be visible after review.")
};

µ.printErrors = function(response) {
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
