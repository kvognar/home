$(document).on('page:change', function() {
    if ($('canvas#sky').length) {
        $('#people').autocomplete({
            source: $('#people').data('people')
        });
        $('#people').on('autocompleteselect', function(e, ui) {
            µ.getDays(ui.item.value)
        });
    }
});

µ.drawDays = function(response) {
    var days = new Set(response.days);
    var total = response.total;

    var c = document.getElementById("sky");
    var ctx = c.getContext('2d');

    ctx.fillStyle = 'white';
    ctx.fillRect(0,0,1000,1000);
    ctx.fillStyle = 'black';

    for (i = 0; i < total; i++) {
        var x = Math.floor(i / 14) * 10;
        var y = i % 14 * 10;
        if (days.has(i+1)) {
            ctx.fillRect(x, y, 10, 10);
        } else {
            ctx.rect(x, y, 10, 10);
        }
        ctx.stroke();
    }
};

µ.getDays = function(name) {
    $.ajax({
        type: 'GET',
        url: $('#sky').data('url'),
        data: { name: name },
        success: µ.drawDays,
        error: µ.failDrawDays
    });
};

µ.failDrawDays = function() {
    console.log("aw.");
};
