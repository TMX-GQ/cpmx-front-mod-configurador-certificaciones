$(document).ready(function() {

    var table = $('#certificationsTable').DataTable();

    var tableDocumentos = $('#documentosDisponibles').DataTable();
    var tableCertificacion = $('#documentosCertificacion').DataTable();

    var tableSecciones = $('#seccionesDisponibles').DataTable();
        var tableSeccionesCert = $('#seccionesCertificacion').DataTable();

    $.post(getCertificacionesURL, {
        clientId: clientID
    })
        .done(function (data) {
            var response = JSON.parse(data);
            console.log('Respuesta:', response);

            table.clear(); // Clear previous data

            response.forEach(item => {
                table.row.add([
                    item.cveCertification,
                    '',
                    item.numeroDocumentos,
                    item.numeroSecciones,
                    item.numNotifDays,
                    '',
                    `<button class="edit-btn" data-client-id="${item.cveCertification}">Ver</button>`
                ]);
             });

            table.draw();
        });

    $('#certificationsTable tbody').on('click', '.edit-btn', function() {
        var certificacion = $(this).data('client-id');

        $.post(manageDocumentsURL, {
            numeroCertificacion: certificacion,
            documentoId: "",
            accion: ""
        }).done(function(dataDoc) {

            var response = JSON.parse(dataDoc);

            console.log(response);

            tableDocumentos.clear(); // Clear previous data

            response.documentosDisponibles.forEach(item => {
                tableDocumentos.row.add([
                    item.idDocumento,
                    item.nombreDocumento
                ]);
             });

            tableDocumentos.draw();
        });

        $.post(manageSectionsURL, {
            numeroCertificacion: certificacion,
            seccionId: "",
            accion: ""
        }).done(function(dataSec) {

            var response = JSON.parse(dataSec);

            console.log(response);

            tableSecciones.clear(); // Clear previous data

            response.seccionesDisponibles.forEach(item => {
                tableSecciones.row.add([
                    item.idSeccion,
                    item.nombreSeccion
                ]);
             });

            tableSecciones.draw();
        });

        $("#modalDetalles").modal('show');
    });
});