$(document).ready(function() {

    var table = $('#certificationsTable').DataTable();

    var tableDocumentos = $('#documentosDisponibles').DataTable();
    var tableCertificacion = $('#documentosCertificacion').DataTable();

    var tableSecciones = $('#seccionesDisponibles').DataTable();
    var tableSeccionesCert = $('#seccionesCertificacion').DataTable();

    $("#documentosDisponibles tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#documentosCertificacion tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#seccionesDisponibles tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $("#seccionesCertificacion tbody").on("click", "tr", function() {
        $(this).toggleClass("selected");
    });

    $.post(getCertificacionesURL, {
        clientId: clientID
    })
        .done(function (data) {
            var response = JSON.parse(data);
            console.log('Respuesta:', response);

            datosCertificaciones = response;

            table.clear(); // Clear previous data

            response.forEach(item => {
                table.row.add([
                    item.cveCertification,
                    '',
                    item.numeroDocumentos,
                    item.numeroSecciones,
                    item.numNotifDays,
                    '',
                    `<button class="btn boton_afiliacion_secundario edit-btn" data-client-id="${item.cveCertification}">Ver</button>`
                ]);
             });

            table.draw();
        });

    $('#certificationsTable tbody').on('click', '.edit-btn', function() {
        certificacion = $(this).data('client-id');

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

            tableCertificacion.clear(); // Clear previous data

            response.documentosActuales.forEach(item => {
                tableCertificacion.row.add([
                    item.idDocumento,
                    item.nombreDocumento
                ]);
             });

            tableCertificacion.draw();
            $('#documentosDisponibles tbody tr').css('cursor', 'pointer');

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

    $("#btnNueva").click(function(data) {
        $("#registraClienteForm").submit();
    });

    $('#sendDocuments').click(function(){
            var allRows = tableCertificacion.rows().data().toArray(); // Get all table rows

            if (allRows.length === 0) {
                alert("No hay elementos en la tabla.");
                return;
            }

            allRows.forEach(function(rowData) {
                var payload = {
                    documentId: rowData[0], // Assuming first column is ID
                    documentName: rowData[1] // Second column
                };

                $.post(manageDocumentsURL,{
                      numeroCertificacion: certificacion,
                      documentoId: payload.documentId,
                      accion: "agregar"
                  })
                .done(function(response) {
                    console.log("Respuesta del servidor:", response);
                }).fail(function(xhr) {
                    console.error("Error:", xhr.responseText);
                });
            });
        });

    $('#agregaDocumento').click(function(){
        $('#documentosDisponibles tbody tr.selected').each(function(){
            var rowData = tableDocumentos.row(this).data(); // Get row data
            tableCertificacion.row.add(rowData).draw(); // Add row to second table
            tableDocumentos.row(this).remove().draw(); // Remove row from first table
        });
    });

    $('#agregaSeccion').click(function(){
        $('#seccionesDisponibles tbody tr.selected').each(function(){
            var rowData = tableSecciones.row(this).data(); // Get row data
            tableSeccionesCert.row.add(rowData).draw(); // Add row to second table
            tableSecciones.row(this).remove().draw(); // Remove row from first table
        });
    });

    $('#seccionesDisponibles tbody').on('click', 'tr', function () {
        $('#seccionesDisponibles tbody tr').removeClass('selected');
        $(this).addClass('selected');
    });


    $('#eliminaDocumento').click(function(){
        $('#documentosCertificacion tbody tr.selected').each(function(){
            var rowData = tableCertificacion.row(this).data(); // Get row data
            tableDocumentos.row.add(rowData).draw(); // Add row to second table
            tableCertificacion.row(this).remove().draw(); // Remove row from first table
        });
    });

    $('#eliminaSeccion').click(function(){
        $('#seccionesCertificacion tbody tr.selected').each(function(){
            var rowData = tableSeccionesCert.row(this).data(); // Get row data
            tableSecciones.row.add(rowData).draw(); // Add row to second table
            tableSeccionesCert.row(this).remove().draw(); // Remove row from first table
        });
    });

    $('#sendSecciones').click(function(){
        var allRows = tableSeccionesCert.rows().data().toArray(); // Get all table rows

        if (allRows.length === 0) {
            alert("No hay elementos en la tabla.");
            return;
        }

        allRows.forEach(function(rowData) {
            var payload = {
                documentId: rowData[0], // Assuming first column is ID
                documentName: rowData[1] // Second column
            };

            $.post(manageSectionsURL,{
                  numeroCertificacion: certificacion,
                  seccionId: payload.documentId,
                  accion: "agregar"
              })
            .done(function(response) {
                console.log("Respuesta del servidor:", response);
            }).fail(function(xhr) {
                console.error("Error:", xhr.responseText);
            });
        });
    });
});