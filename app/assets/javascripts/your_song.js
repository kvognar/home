$(document).on('page:change', function() {
    if ($('canvas#sky').length) {
        µ.getDays();
        $('#people').autocomplete({
            source: ["laurel", "alina", "bob"]
        });
    }
});

µ.drawDays = function(response) {
    var days = new Set(response.days);
    var total = response.total;

    var c = document.getElementById("sky");
    var ctx = c.getContext('2d');

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

µ.getDays = function() {
    $.ajax({
        type: 'GET',
        url: $('#sky').data('url'),
        success: µ.drawDays,
        error: µ.failDrawDays
    });
};

µ.failDrawDays = function() {
    console.log("aw.");
};
