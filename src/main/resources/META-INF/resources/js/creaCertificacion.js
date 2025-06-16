$(document).ready(function() {

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
                  numeroCertificacion: dataCert.numeroCertificacion,
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

    $("#guardarCertificacion").click(function() {
        console.log('Intentando Guardar');
        const diasNotificacion = $('input[name="diasNotificacion"]').val();
        const regimenFiscal = $('input[name="regimenFiscal"]:checked').val();
        const tipoPago = $('input[name="tipoPago"]:checked').val();
        const montoCertificacion = $('input[name="monto"]').val();

        console.log("Días Notificación:", diasNotificacion);
        console.log("Régimen Fiscal:", regimenFiscal);
        console.log("Tipo de Pago:", tipoPago);
        console.log("Monto Certificación:", montoCertificacion);

        $.post(creaCertificacionURL, {
            clientId: clientId,
            regimenFiscal: regimenFiscal,
            diasNotificacion: diasNotificacion,
            montoCertificacion: montoCertificacion,
            clienteProveedor: tipoPago,
            registoUsuario: 1
        }).done(function(data) {

            dataCert = data;

            console.log(dataCert.numeroCertificacion);

            $.post(manageDocumentsURL, {
                numeroCertificacion: dataCert.numeroCertificacion,
                documentoId: "",
                accion: ""
            }).done(function(dataDoc) {

                var response = JSON.parse(dataDoc);

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
                numeroCertificacion: dataCert.numeroCertificacion,
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

            $(".containerSecciones").removeClass('d-none');
            $(".containerDocumentos").removeClass('d-none');
        });
    });
});