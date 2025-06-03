$(document).ready(function() {

    var table = $('#clientTable').DataTable();

    $("#btnBuscar").on('click', function() {
        console.log('Buscando cliente');

        if($("#idCliente").val() == "" && $("#nombreCliente").val() == "") {
            alert('Se debe ingresar Nombre o ID del Cliente');
            return;
        }

        $.post(getClientURL, {
            clientId: $("#idCliente").val(),
            clientName: $("#nombreCliente").val()
        })
            .done(function (data) {
                var response = JSON.parse(data);
                console.log('Respuesta:', response);

                if(response.certificaciones) {
                    table.clear(); // Clear previous data
                    table.row.add([
                    response.clienteId,
                    response.nombreComercial,
                    '',
                    response.rfc,
                    `<button class="edit-btn" data-client-id="${response.clienteId}">Edit</button>`
                    ]); // Add new row
                    table.draw();
                }
                else {
                    $("#registraClienteForm").submit();
                }
            });

        //$("#modalAlertaCliente").modal("show");
    });

    $("#registrarCliente").on('click', function() {
        $("#registraClienteForm").submit();
    });

    $('#clientTable tbody').on('click', '.edit-btn', function() {
            var clientId = $(this).data('client-id');
            console.log(clientId);
            $("#clientId").val(clientId);
            $("#editaCertificacionForm").submit();
        });
});