$(document).ready(function() {
    console.log('ready');
    init();
});

//Funcion que inicializa
function init(){
    $('select').formSelect();
    $('#modal-login').modal();
    $('#modal-listaApuestas').modal();
    $('#modal-apostar').modal();
    $('.modal-trigger').modal();
    apostar();
    loadApuestas();
}

//Funcion para cargar la tabla de apuestas mediante ajax
function loadApuestas(){
    $('#modal-listaApuestas').modal({
        onOpenEnd: function(modal, trigger) {
            $.ajax({
                type: "POST",
                url: "Controller?op=infoapuestas&idpartido=" + trigger.data('id'),
                success: function (info) {
                    $("#div-apuestas").html(info);
                }
            });
        }
    });
}

//Funcion que mete los datos necesarios para hacer la apuesta
function apostar(){
    $('#modal-apostar').modal({
        onOpenEnd: function(e) {
            //$("idPartido").val("hola");
            $("#partido").text($(e.relatedTarget).data('nom'));
        }
    });
}



