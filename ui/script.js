$(document).ready(function(){
    $('.Main').css('display','none');
    window.addEventListener( 'message', function( event ) {
        var a = event.data
        if (a.action == 'showInterface') {
            
            if (a.creator) {
                $('.Main').css('display','block');
            } else {
                $('#opcion1').css('display','none');
                $('.Main').css('display','block');
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
        $(".creator").show()
    }

    document.getElementById("opcion2").onclick = function() {
        $(".menu").hide()
        $('.initial').css('display','block');
    }

    document.getElementsByClassName("btn")[0].onclick = function() {
        $(".menu").show()
        $(".creator").hide()
    }

    document.getElementsByClassName("btn3")[0].onclick = function() {
        $(".menu").show()
        $(".initial").hide()
    }

    document.getElementById("btn2").onclick = function() {
        const valor = document.getElementById("input").value;
        $.post('https://Fo4rWelcome/creatorcode', JSON.stringify({valor: valor}));
        closeAll()
    };
})

function closeAll() {
    $(".Main").hide()
    $.post('https://Fo4rWelcome/closew', JSON.stringify({}))
}