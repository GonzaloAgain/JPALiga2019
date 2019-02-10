$(document).ready(function() {
    console.log('ready');
    init();
});

//Funcion que inicializa
function init(){
    loadApuestas();
    $('select').material_select();
    $('#modal-login').modal();
    $('#modal-listaApuestas').modal();
    $('#modal-apostar').modal();
    $('.modal-trigger').modal();
    apostar();
}

//Funcion para cargar la tabla de apuestas mediante ajax
function loadApuestas(){
    $('#modal-listaApuestas').modal({
        ready: function(modal, trigger) {
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
        ready: function(modal, trigger) {
            modal.find('input[name="idPartido"]').val(trigger.data('id'));
            modal.find('h5[id="partido"]').text(trigger.data('nom'));
        }
    });
}



