//= require dropzone

Dropzone.autoDiscover = false;

µ.readyDayEdit = function () {
    if($('#photo-dropzone').length) {
        var photoUpload = new Dropzone('#photo-dropzone');
        photoUpload.on('success', µ.showPhoto);
    }
    if($('#bonus-dropzone').length) {
        var photoUpload = new Dropzone('#bonus-dropzone');
        photoUpload.on('success', function(file, response) {
            µ.showBonusPhoto(file, response, photoUpload);
        });
    }

    µ.hasChanged = false;
    µ.saveCountdown = 3;
    µ.draftInterval = setInterval(µ.saveDraft, 1000);

    $('#sidebar-button').on('click', function(event) {
        event.preventDefault();
        $('.day-form-sidebar').toggleClass('active');
    });

    $('form #day_body').on('input', function() {
        µ.hasChanged = true;
        µ.saveCountdown = 3;
        $('.save-state').removeClass('saved');
    });

    $('.good-night').on('click', µ.submitDay);

    $('.day-data-container-toggle').on('click', function(event) {
        event.preventDefault();
        $('.day-data-container').toggleClass('glass');
    });
};

$(document).on('turbolinks:load', function() {
    if ($('body.days.new').length || $('body.days.edit').length) {
        µ.readyDayEdit();
    }
});

// Triggers

µ.saveDraft = function() {
    µ.saveCountdown--;
    if(µ.hasChanged && µ.saveCountdown < 1 && $('#day_is_draft').attr('value') === 'true') {
        var dayForm = $('#day-form');
        µ.hasChanged = false;
        $.ajax({
            type: dayForm.data('method'),
            url: dayForm.attr('action'),
            data: dayForm.serialize(),
            success: µ.handleDraftUpdate,
            error: µ.handleDraftUpdateFailure
        });
    }
};

µ.submitDay = function(event) {
    event.preventDefault();
    clearInterval(µ.draftInterval);
    $('#day_is_draft').val('false');
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
    $('.dropzone#photo-dropzone').hide();
};
µ.showBonusPhoto = function(file, response, dropzone) {
    dropzone.removeFile(file);
    $('#bonus-container').append('<img class="photo-preview" src="' + response.url + '">');
    $('#bonus-container').append('<code>' + response.url + '</code>');

}

// Response callbacks

µ.addLinkToDay = function(response) {
    $('.continue-container').html('<a class="sleep-well" target="_blank" href=' + response.url + '>Sleep well.</a>')
};

µ.handleSubmissionResponse = function(response) {
    µ.addLinkToDay(response);
};

µ.handleDraftUpdate = function(response) {
    $('.save-state').addClass('saved');
    µ.hasChanged = false;
};

µ.handleDraftUpdateError = function(response) {
    $('.save-state').addClass('error');
};

µ.printErrors = function(response) {
    $('.error-container').html('<ul></ul>');
    response.responseJSON.errors.forEach(function(error) {
        $('.error-container ul').append('<li>' + error + '</li>')
    })
};
