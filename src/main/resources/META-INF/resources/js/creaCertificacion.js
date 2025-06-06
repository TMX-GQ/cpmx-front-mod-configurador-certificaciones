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

    $("#guardarCertificacion").click(function() {
        console.log('Intentando Guardar');

        $.post(creaCertificacionURL, {
            clientId: clientId,
            regimenFiscal: 'Fisico',
            diasNotificacion: 1,
            montoCertificacion: 12000,
            clienteProveedor: 1,
            registoUsuario: 1
        }).done(function(data) {

            var dataCert = JSON.parse(data);

            $.post(manageDocumentsURL, {
                numeroCertificacion: 1,
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
                numeroCertificacion: 1,
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