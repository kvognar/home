$(document).on('page:change', function() {
    if ($('canvas#sky').length) {
        $('#people').autocomplete({
            source: $('#people').data('people')
        });
        $('#people').on('autocompleteselect', function(e, ui) {
            µ.getDays(ui.item.value)
        });

        $('canvas#sky').on('mousemove', function(e) {
            var c = document.getElementById("sky");
            var pos = µ.getMousePos(c, e);

            var day = Math.floor((pos.y/20%14)+1) + Math.floor((pos.x/20))*14;
            console.log(day)
            $('#sky').attr("title", "Day " + day);
        });

        $('canvas#sky').on('click', function(e) {
            var c = document.getElementById("sky");
            var pos = µ.getMousePos(c, e);
            var day = Math.floor((pos.y/20%14)+1) + Math.floor((pos.x/20))*14;
            µ.getDay(day);
        })
    }
});

µ.drawDays = function(response) {
    var days = new Set(response.days);
    var total = response.total;

    var daySize = 20;
    var width = $('#sky').width();

    var c = document.getElementById("sky");
    var ctx = c.getContext('2d');

    // fill by width/height

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
    ctx.strokeStyle = "#dddddd";
    for (x = 0; x*daySize < width; x++) {
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

µ.getMousePos = function(canvas, event) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: event.clientX - rect.left,
        y: event.clientY - rect.top
    }
};

µ.getDays = function(name) {
    $.ajax({
        type: 'GET',
        url: $('#sky').data('index-url'),
        data: { name: name },
        success: µ.drawDays,
        error: µ.failDrawDays
    });
};

µ.getDay = function(number) {
    $.ajax({
        type: 'GET',
        url: $('#sky').data('show-url') + "/" + number,
        success: µ.showDay,
        error: µ.failDrawDays
    })
};

µ.showDay = function(response) {
    $('.day-container').html(response.html);
};

µ.failDrawDays = function() {
    console.log("aw.");
};
