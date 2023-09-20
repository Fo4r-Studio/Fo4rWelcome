$(document).ready(function(){
    $('.Main').css('display','none');
    window.addEventListener( 'message', function( event ) {
        var a = event.data
        if (a.action == 'showInterface') {
            $("#servername").empty();
            $('#servername').append(`${a.svname}`);
            if (a.creator) {
                $('.Main').css('display','block');
            } else {
                $('#opcion1').css('display','none');
                $('.Main').css('display','block');
            }
            if (a.rw) {
                $('.Main').css('display','block');
            } else {
                $('#opcion2').css('display','none');
                $('.Main').css('display','block');
            }
        } else if (a.action == 'checkreward') {
            if (a.posible) {
                $('.norecibed').css('display','block');
                $('.isrecibed').css('display','none');
            } else {
                $('.isrecibed').css('display','block');
                $('.norecibed').css('display','none');
            }
        } else if (a.action == 'checkcreatorcode') {
            if (a.posiblec) {
                $('.crnorecibe').css('display','block');
                $('.crisrecibe').css('display','none');
            } else {
                $('.crnorecibe').css('display','none');
                $('.crisrecibe').css('display','block');
            }
        }
    })

    $(document).keyup(function(e) {
        if ( e.keyCode == 27) {
            closeAll() 
        }
    });

    document.getElementById("opcion1").onclick = function() {
        $(".menu").hide()
        $(".title").hide()
        $(".creator").show()
        $.post('https://Fo4rWelcome/checkcreatorcode', JSON.stringify({}))
    }

    document.getElementById("opcion2").onclick = function() {
        $(".menu").hide()
        $(".title").hide()
        $('.initial').show()
        $.post('https://Fo4rWelcome/initialreward', JSON.stringify({}))
    }

    document.getElementsByClassName("btn")[0].onclick = function() {
        $(".menu").show()
        $(".title").show()
        $(".creator").hide()
    }

    document.getElementsByClassName("btn3")[0].onclick = function() {
        $(".menu").show()
        $(".title").show()
        $(".initial").hide()
    }

    document.getElementById("btn2").onclick = function() {
        $(".menu").show()
        $(".title").show()
        $(".crnorecibe").hide()
        const valor = document.getElementById("input").value;
        $.post('https://Fo4rWelcome/creatorcode', JSON.stringify({valor: valor}));
        closeAll()
    };
})

function closeAll() {
    $(".Main").hide()
    $.post('https://Fo4rWelcome/closew', JSON.stringify({}))
}