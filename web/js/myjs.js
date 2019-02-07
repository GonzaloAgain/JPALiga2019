$(document).ready(function() {
    console.log('ready');
    $('select').formSelect();
    init();
});

//Funcion que inicializa
function init(){
    loadApuestas()
    $('#modal-login').modal();
    $('#modal-listaApuestas').modal();
    $('#modal-apostar').modal();
    $('.modal-trigger').modal();
    apostar()
}

//Funcion para cargar la tabla de apuestas mediante ajax
function loadApuestas(){
    $('#modal-listaApuestas').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idPartido = button.data('id');
        $.ajax({
            type: "POST",
            url: "Controller?op=infoapuestas&idpartido=" + idPartido,
            success: function (info) {
                $("#div-apuestas").html(info);
            }
        });
    });
}

//Funcion que mete los datos necesarios para hacer la apuesta
function apostar(){
    $('#modal-apostar').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var idpartido = button.data('id')
        var partido=button.data('whatever')// Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)
        modal.find('#idPartido').val(idpartido)
        modal.find('#partido').val(partido)
      })
}



