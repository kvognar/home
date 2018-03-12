µ.readyDayShow = function () {
    $('#comments').on('click', '.submit-comment', µ.submitComment);

    $('.reply-link').on('click', µ.showCommentForm);
};


$(document).on('turbolinks:load', function() {
    if ($('body.days.show').length) {
        µ.readyDayShow();
    }
});

// Triggers

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
    var $commentForm = $(event.currentTarget).parent();
    $.ajax({
        type: $commentForm.data('method'),
        url: $commentForm.attr('action'),
        data: $commentForm.serialize(),
        success: function() { µ.handleCommentResponse($commentForm); },
        error: function (response) {
            console.log(response.responseJSON.errors)
            var $errorContainer = $commentForm.find('.error-container')
            $errorContainer.html('<ul></ul>');
            response.responseJSON.errors.forEach(function(error) {
                $errorContainer.append('<li>' + error + '</li>')
            })
        }
    });
};

µ.handleCommentResponse = function($commentForm) {
    $commentForm.html("Thanks! Your comment will be visible after I take a look.")
};
