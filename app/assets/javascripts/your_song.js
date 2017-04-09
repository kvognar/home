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

    var daySize = 20;

    var c = document.getElementById("sky");
    var ctx = c.getContext('2d');

    ctx.fillStyle = 'white';
    ctx.fillRect(0,0,1000,1000);
    ctx.fillStyle = 'darkblue';

    for (i = 0; i < total; i++) {
        var x = Math.floor(i / 14) * daySize;
        var y = i % 14 * daySize;
        if (days.has(i+1)) {
            ctx.fillRect(x, y, daySize, daySize);
        }
        ctx.stroke();
    }
    ctx.strokeStyle = "#dddddd"
    for (x = 0; x < 100; x++) {
        ctx.beginPath();
        ctx.moveTo(x*daySize, 0);
        ctx.lineTo(x*daySize, 300);
        ctx.closePath();
        ctx.stroke();
    }
    for (y = 0; y < 14; y++) {

        ctx.beginPath();
        ctx.moveTo(0, y*daySize);
        ctx.lineTo(1000, y*daySize);
        ctx.closePath();
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
